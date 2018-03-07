#' Calculate Entropy Statistics
#'
#' Because it's possible to have multiple results with a minimum number of
#' samples, one way of assessing their importance is to calculate how
#' distributed the alleles are among the samples. This can be done with entropy
#' statistics
#'
#' @param tab a numeric matrix
#' @param f a factor that is the same length as the number of columns in `tab`.
#'   this is used to split the matrix up by groups for analysis.
#'
#' @return a data frame with three columns: `eH`, `G`, `E5`, `lambda`, and
#'   `missing`
#' @details This function caluclates four statistics from your data using
#'   variable counts.
#'
#'   * eH: The exponentiation of shannon's entropy: `exp(sum(-x * log(x)))`
#'   (Shannon, 1948)
#'   * G : Stoddart and Taylor's index, or inverse Simpson's index: `1/sum(x^2)`
#'   (Stoddart and Taylor, 1988; Simpson, 1949)
#'   * E5: Evenness (5) the ratio between the above two estimates:
#'   `(G - 1)/(eH - 1)` (Pielou, 1975)
#'   * lambda: Unbiased Simpson's index: `(n/(n-1))*(1 - sum(x^2))`
#'   * missing: the percent missing data out of the total number of cells.
#'
#'   Both G and eH can be thought of as the number of equally abundant variables
#'   to acheive the same observed diversity. Both G and eH give different weight
#'   to variables based on their abundance, so we use evenness to describe how
#'   uniform this distribution is.
#'
#'   Note that this version of Evenness is different than Shannon's Evenness,
#'   which is `H/ln(S)` where S is the number of variables (in our case).
#'
#'   If a vector of factors is supplied, the columns of the matrix is first
#'   split by this factor and each statistic calculated on each level.
#'
#' @note The calculations within this function are derived from the vegan and
#'   poppr R packages.
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
#'
#' # Calculate statistics for the whole data set -----------------------------
#'
#' data(monilinia)
#' entropy(monilinia)
#'
#' # Use a grouping factor for variables -------------------------------------
#' # Each variable in this data set represents and allele that is one of
#' # thirteen loci. If we wanted a table across all loci individually, we can
#' # group by locus name.
#'
#' f <- gsub("[.][0-9]+", "", colnames(monilinia))
#' f <- factor(f, levels = unique(f))
#' colMeans(emon <- entropy(monilinia, f = f)) # average entropy across loci
#' emon
#'
#' # calculating entropy for minimum sets ------------------------------------
#'
#' set.seed(1999)
#' i <- find_samples(monilinia, n = 150, cut = TRUE)
#' colMeans(emon1 <- entropy(monilinia[i[[1]], ], f = f))
#' colMeans(emon2 <- entropy(monilinia[i[[2]], ], f = f))
#'
entropy <- function(tab, f = NULL) {
  if (!is.null(f)) {
    if (length(f) != ncol(tab)) {
      stop("f must be the same number of columns as tab")
    }
    if (!is.factor(f)) {
      warning("f is not a factor. I am coercing f to be a factor in order")
      f <- factor(f, levels = unique(f))
    }
    groups <- split.matrix(tab, f)
    res    <- lapply(groups, entropy, f = NULL)
    resdf  <- do.call("rbind", res)
    return(resdf)
  }
  tabsums <- colSums(tab, na.rm = TRUE)
  n       <- sum(tabsums)
  x       <- tabsums/(sum(tabsums))
  sx2     <- sum(x * x)
  H       <- exp(sum(-x * log(x)))
  G       <- 1/(sx2)
  lambda  <- (n/(n - 1)) * (1 - sx2)
  E5      <- (G - 1)/(H - 1)
  missing <- sum(is.na(tab))/length(tab)
  data.frame(eH = H, G = G, E5 = E5, lambda = lambda, missing = missing)
}

split.matrix <- function(x, f, ...){
  tmp <- split.default(x, f[col(x)], ...)
  lapply(tmp, matrix, nrow = nrow(x))
}
