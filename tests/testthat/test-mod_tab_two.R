#testing reactive values from mod_tab_two_server
testServer(
  mod_tab_two_server,
  # Add here your module params
  args = list(variableInput = reactive("price_sales")), {
    #test whether the logical reactive vector called indicator returns exactly one TRUE value as expected
    expect_true(
      sum(indicator())==1
    )

    #test whether selection was excluded in variables_without_selection variable
    expect_false(
      variableInput() %in% variables_without_selection()
    )

    #test whether only selection was excluded in variables_without_selection variable
    expect_true(
      length(variables_without_selection()) == length(selected_names) - 1
    )
  }
)

#default tests already built in from golem
test_that("module ui works", {
  ui <- mod_tab_two_ui(id = "test")
  golem::expect_shinytaglist(ui)
  # Check that formals have not been removed
  fmls <- formals(mod_tab_two_ui)
  for (i in c("id")){
    expect_true(i %in% names(fmls))
  }
})

