context("entropy tests")

data(monilinia)
exp <- data.frame(eH = 43.9973672793747,
                  G = 33.3633662161927,
                  E5 = 0.752682507417542,
                  lambda = 0.970312895921983,
                  missing = 0.0100079744816587
                  )
mexp <-          c(eH = 3.62446099,
                   G = 2.89447982,
                   E5 = 0.72184259,
                   lambda = 0.61097340,
                   missing = 0.01107226
                   )
test_that("entropy function returns a data frame", {
  expect_is(res <- entropy(monilinia), "data.frame")
  expect_equal(res, exp)
})

test_that("entropy functions will split given a factor", {
  f <- gsub("[.][0-9]+", "", colnames(monilinia))
  expect_warning(emon1 <- entropy(monilinia, f = f), "f is not a factor")
  f <- factor(f, levels = unique(f))
  emean <- colMeans(emon <- entropy(monilinia, f = f)) # average entropy across loci
  expect_is(emon, "data.frame")
  expect_equal(emean, mexp)
  expect_equal(emon1, emon)
})

test_that("entropy function will get angry if the factor is incorrect", {
  expect_error(entropy(monilinia, factor(letters)), "f must be")
})
