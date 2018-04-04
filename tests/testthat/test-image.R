context("visualization tests")

test_that("plotting works", {
  data("monilinia")
  loci <- sapply(strsplit(colnames(monilinia), "[.]"), "[", 1)
  expect_null(rpv_image(monilinia, f = loci, highlight = rpv_indices(monilinia)))
})
