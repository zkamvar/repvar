#' Iteratively find minimum set of samples by shuffling rows
#'
#' Because [get_minimum_set()] is deterministic, it may not present the
#' minimum set that represents all variables. This procedure automates the
#' process of randomly sampling the rows in the incoming matrix without
#' replacement to find a minimum set.
#'
#' @param tab a numeric matrix with rownames
#' @param n the number of permutations to perform
#' @param sort when `TRUE` (default), the returned list will be sorted in order
#'   of number of samples.
#' @param cut when `TRUE`, only the results with the minimum number of samples
#'   will be returned.
#'
#' @return a list of character vectors
#' @export
#'
#' @examples
#' data(monilinia)
#' # Iterate over the data 100 times and return only the minimum values
#' set.seed(2018)
#' find_samples(monilinia, n = 100, cut = TRUE)
#'
#' # This is a random process and will not always return the same values
#' set.seed(201)
#' find_samples(monilinia, n = 100, cut = TRUE)
find_samples <- function(tab, n = 10, sort = TRUE, cut = FALSE) {
  res <- vector(mode = "list", length = n)
  for (i in seq(n)) {
    res[[i]] <- get_minimum_set(tab[sample(nrow(tab)), , drop = FALSE])
  }
  lens <- lengths(res)
  if (sort) {
    lsort <- sort.int(lens, index.return = TRUE)
    res  <- res[lsort$ix]
    lens <- lsort$x
  }
  if (cut) {
    res <- res[lens == min(lens)]
  }
  res
}
