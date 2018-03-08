#' Iteratively find minimum set of samples by shuffling rows
#'
#' Because [rpv_indices()] is deterministic, it may not present the
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
#' @param progress when `TRUE`, a progress bar will be displayed.
#'
#' @return a list of character vectors
#' @export
#'
#' @examples
#' data(monilinia)
#' # Iterate over the data 100 times and return only the minimum values
#' set.seed(2018)
#' rpv_find(monilinia, n = 100, cut = TRUE, progress = FALSE)
#'
#' # This is a random process and will not always return the same values
#' set.seed(201)
#' rpv_find(monilinia, n = 100, cut = TRUE, progress = FALSE)
rpv_find <- function(tab, n = 10, sort = TRUE, cut = FALSE, progress = TRUE) {
  res <- vector(mode = "list", length = n)
  if (progress) prog <- utils::txtProgressBar(min = 0, max = n + sum(sort, cut), style = 3)
  for (i in seq(n)) {
    res[[i]] <- rpv_indices(tab[sample(nrow(tab)), , drop = FALSE])
    if (progress) utils::setTxtProgressBar(prog, i)
  }
  lens <- lengths(res)
  if (sort) {
    lsort <- sort.int(lens, index.return = TRUE)
    res  <- res[lsort$ix]
    lens <- lsort$x
    if (progress) utils::setTxtProgressBar(prog, n + sort)
  }
  if (cut) {
    res <- res[lens == min(lens)]
    if (progress) utils::setTxtProgressBar(prog, n + sort + cut)
  }
  if (progress) close(prog)
  res
}
