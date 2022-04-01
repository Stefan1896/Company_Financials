#testing reactive value from mod_tab_one_server
testServer(
  mod_tab_one_server,
  # Add here your module params
  args = list(variableInput = reactive("price_earnings")), {
    #test whether the logical reactive vector called indicator returns exactly one TRUE value as expected
    expect_true(
      sum(indicator())==1
    )

    #test whether missing data of selected variable are removed through 2 tests:
    expect_true(
      sum(is.na(financials$price_earnings)) > 0
    )
    expect_true(
      sum(is.na(financials_no_missing()$price_earnings)) == 0
    )
  }
)

#default tests already built in from golem
test_that("module ui works", {
  ui <- mod_tab_one_ui(id = "test")
  golem::expect_shinytaglist(ui)
  # Check that formals have not been removed
  fmls <- formals(mod_tab_one_ui)
  for (i in c("id")){
    expect_true(i %in% names(fmls))
  }
})
