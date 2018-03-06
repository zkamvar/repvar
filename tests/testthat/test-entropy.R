context("entropy tests")

data(monilinia)
exp <- data.frame(eH = 43.9973672793747, G = 33.3633662161927, E5 = 0.752682507417542)
test_that("entropy function returns a data frame", {
  expect_is(res <- entropy(monilinia), "data.frame")
  expect_equivalent(res, exp)
})
