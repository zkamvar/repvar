context("Basic Sanity Checks")

mat            <- matrix(0L, nrow = 10, ncol = 10)
diag(mat)      <- 1L
mat2           <- rbind(mat, mat)
rownames(mat2) <- paste(letters[1:10], rep(c("?", "!"), each = 10))
colnames(mat2) <- LETTERS[1:10]
the_seed <- eval(parse(text = as.character(Sys.Date())))


test_that("the data must have row names", {
  expect_error(rpv_indices(mat), "rowname")
})


test_that("the minimum number of rows will be returned", {
  the_rows <- rpv_indices(mat2)
  expect_length(the_rows, 10)
  for (i in 1:10) {
    expect_match(the_rows[i], letters[i], label = letters[i])
  }
})

test_that("shuffled data will give the same result in this case", {
  set.seed(the_seed)
  the_rows <- rpv_find(mat2, n = 2, sort = TRUE, progress = FALSE)[[2]]
  expect_length(the_rows, 10)
  for (i in 1:10) {
    expect_match(the_rows[i], letters[i], label = letters[i])
  }
})

test_that("no row will be missed", {
  data("monilinia", package = "repvar")
  set.seed(the_seed)
  res    <- rpv_indices(monilinia[sample(nrow(monilinia)), ])
  counts <- colSums(monilinia[res, ], na.rm = TRUE)
  expect_lt(length(res), nrow(monilinia))
  expect_true(all(counts > 0), info = paste("seed:", the_seed))
})

test_that("cut works", {
  skip_on_cran()
  set.seed(the_seed)
  res <- rpv_find(monilinia, n = 100, cut = TRUE, progress = FALSE)
  expect_lt(length(res), 100)
  expect_true(all(lengths(res) == length(res[[1]])))
})
