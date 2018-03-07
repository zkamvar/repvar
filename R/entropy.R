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
#' @details This function caluclates three statistics from your data using
#'   variable counts.
#'
#' * eH: The exponentiation of shannon's entropy: `exp(sum(-x * log(x)))`
#'  (Shannon, 1948)
#' * G : Stoddart and Taylor's index, or inverse Simpson's
#'  index: `1/sum(x * x)` (Stoddart and Taylor, 1988; Simpson, 1949)
#' * E5: Evenness (5) the ratio between the above two estimates:
#'  `(G - 1)/(eH - 1)` (Pielou, 1975)
#'
#'  Both G and eH can be thought of as the number of equally abundant variables
#'  to acheive the same observed diversity. Both G and eH give different weight
#'  to variables based on their abundance, so we use evenness to describe how
#'  uniform this distribution is.
#'
#'  Note that this version of Evenness is different than Shannon's Evenness,
#'  which is `H/ln(S)` where S is the number of variables (in our case).
#'
#' @export
#' @references
#'
#' Claude Elwood Shannon. A mathematical theory of communication. Bell Systems
#' Technical Journal, 27:379-423,623-656, 1948
#'
#' Simpson, E. H. Measurement of diversity. Nature 163: 688, 1949
#' doi:10.1038/163688a0
#'
#' J.A. Stoddart and J.F. Taylor. Genotypic diversity: estimation and prediction
#' in samples. Genetics, 118(4):705-11, 1988.
#'
#' E.C. Pielou. Ecological Diversity. Wiley, 1975.
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
