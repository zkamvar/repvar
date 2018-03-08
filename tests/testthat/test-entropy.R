context("rpv_stats tests")

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
test_that("rpv_stats function returns a data frame", {
  expect_is(res <- rpv_stats(monilinia), "data.frame")
  expect_equal(res, exp)
})

test_that("rpv_stats functions will split given a factor", {
  f <- gsub("[.][0-9]+", "", colnames(monilinia))
  expect_warning(emon1 <- rpv_stats(monilinia, f = f), "f is not a factor")
  f <- factor(f, levels = unique(f))
  emean <- colMeans(emon <- rpv_stats(monilinia, f = f)) # average entropy across loci
  expect_is(emon, "data.frame")
  expect_equal(emean, mexp)
  expect_equal(emon1, emon)
})

test_that("rpv_stats function will get angry if the factor is incorrect", {
  expect_error(rpv_stats(monilinia, factor(letters)), "f must be")
})
