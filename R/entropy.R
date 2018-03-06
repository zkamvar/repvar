#' Calculate Entropy Statistics
#'
#' Because it's possible to have multiple results with a minimum number of
#' samples, one way of assessing their importance is to calculate how
#' distributed the alleles are among the samples. This can be done with entropy
#' statistics
#'
#' @param tab a numeric matrix
#'
#' @return a data frame with three columns: `eH`, `G`, and `E5`
#' @export
#'
#' @examples
#' data(monilinia)
#' entropy(monilinia)
#' set.seed(1999)
#' i <- find_samples(monilinia, n = 150, cut = TRUE)
#' entropy(monilinia[i[[1]], ])
#' entropy(monilinia[i[[2]], ])
entropy <- function(tab) {
  tabsums <- colSums(tab, na.rm = TRUE)
  x       <- tabsums/(sum(tabsums))
  H       <- exp(sum(-x * log(x)))
  G       <- 1/(sum(x * x))
  E5      <- (G - 1)/(H - 1)
  data.frame(eH = H, G = G, E5 = E5)
}
