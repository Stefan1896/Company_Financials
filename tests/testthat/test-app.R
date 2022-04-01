test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

#check if janitor::make_clean_names process input string as expected
testServer(app_server, {
  session$setInputs(variable = "Sales/Price")
  expect_equal(selected_variable(), "sales_price")
})
