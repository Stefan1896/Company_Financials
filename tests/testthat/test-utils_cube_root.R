test_that("cube root transformation works for negative values", {
  expect_true(cube_root(-5) < 0)
  expect_true(cube_root(-18) < 0)
  expect_true(cube_root(0) == 0)
})
