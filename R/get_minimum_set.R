#' Get minimum set of individual indices to represent all alleles in a population
#'
#' @param tab an n x m matrix of individuals in rows and alleles in columns.
#'
#' @return a vector of integers representing row indices in the `tab`
#'
#' @export
#' @examples
#' data(monilinia)
#' i <- get_minimum_set(monilinia)
#' i
#' all(colSums(monilinia[i, ], na.rm = TRUE)) > 0
get_minimum_set <- function(tab) {
  if (is.null(rownames(tab))){
    stop("This function requires rownames.")
  }
  # setup -------------------------------------------------------------------
  # We want to accumulate alleles from the rarest to the most abundant. Because
  # each individual has m x p alleles, we know that we will sweep up the
  # abundant alleles on our way. For this, we need three vectors.
  #
  # counts     - vector of allele counts in the whole population
  # all_counts - sorted vector of count classes from smallest to largest.
  #
  # columns_to_inspect - same length as `counts`: a vector of logical values
  #                      that indicate alleles that have yet to be accumulated
  #                      in our final result.
  counts     <- colSums(tab, na.rm = TRUE)
  all_counts <- unique(sort(counts))
  columns_to_inspect <- rep(TRUE, ncol(tab)) & counts > 0

  # iterations --------------------------------------------------------------
  # This loop iterates through each count class and finds all of the alleles
  # that have that many samples present, creating a logical candidate matrix
  # that contains only those alleles with NAs removed.
  j       <- 1
  samples <- integer(0)
  # sams <- rep(FALSE, nrow(tab))
  while (sum(columns_to_inspect) > 0) {
    a          <- all_counts[j]
    my_columns <- counts == a & columns_to_inspect
    if (sum(my_columns) > 0) {
      candidates <- tab[, my_columns, drop = FALSE] > 0
      candidates[is.na(candidates)] <- FALSE

      inds    <- na.omit(apply(candidates, 2, function(x) which(x)[1]))
      samples <- unique(c(samples, unique(inds)))

      # allele_counts <- rowSums(candidates, na.rm = TRUE)
      # tmpsam        <- sams | allele_counts > 0
      # # check for any alleles represented more than once
      # dupes         <- colSums(candidates[allele_counts > 0, , drop = FALSE]) > 1
      # if (any(dupes)){
      #   # check to see which ones have the most needed alleles
      #   i   <- 1
      #   acv <- unique(sort(allele_counts, decreasing = TRUE))
      #   while (any(dupes)){
      #     # Try to update the columns_to_inspect AND the samples
      #     idx           <- allele_counts == acv[i] # gather all samples with multiple alleles
      #     # count the number of alleles/sample
      #     # cross product of matrix can tell you how many alleles are shared between isolates
      #     tmpcandidates <- tab[idx, , drop = FALSE] > 0
      #     tmpcandidates[is.na(tmpcandidates)] <- FALSE
      #     candidate_allele_count <- rowSums(tmpcandidates[, columns_to_inspect, drop = FALSE])
      #     for (k in sort(unique(candidate_allele_count))){
      #       tmpcandidates[candidate_allele_count == k, , drop = FALSE]
      #     }
      #     i <- i + 1
      #   }
      #   rowSums(candidates[, dupes, drop = FALSE])
      # } else {
      #   sams <- tmpsamp
      # }

      columns_to_inspect <- columns_to_inspect & colSums(tab[samples, , drop = FALSE], na.rm = TRUE) == 0
      # cat(length(columns_to_inspect) - sum(columns_to_inspect), "variables accounted for!\r")
    }
    if (j == length(all_counts) | sum(columns_to_inspect) == 0){
      break
    }
    j <- j + 1
  }
  if (sum(columns_to_inspect) > 0) {
    out <- paste(names(columns_to_inspect[columns_to_inspect]), collapse = ", ")
    warning(paste("the following loci are still missing:", out))
  }
  rownames(tab[samples, ])
}
