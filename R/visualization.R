#' Create an image of the data matrix
#'
#' @inheritParams rpv_stats
#' @param highlight a character vector specifing which row names or indices to
#'   highlight.
#' @param newplot When `TRUE` (default), The image will not over-write the
#'   previous image. Turn this off if you want to use multi-panel plotting.
#' @param col a two-color vector for the values of the matrix.
#' @param idcol a two-color vector for the highlight values.
#'
#' @return NULL, invisibly
#' @export
#'
#' @details This function creates a plot that will allow you to visualize a
#'   matrix, optionally overlaying data. Note: the values here represent the
#'   presence/absence of a variable, but does not represent the dosage.
#'
#' @examples
#' data(monilinia)
#' loci <- sapply(strsplit(colnames(monilinia), "[.]"), "[", 1)
#' rpv_image(monilinia, f = loci)
#' rpv_image(monilinia, f = loci, highlight = rpv_indices(monilinia))
rpv_image <- function(tab, f = NULL, highlight = NULL, newplot = TRUE,
                      col = c("#A6CEE3", "#1F78B4"),
                      idcol = c("#FFFF99", "#B15928")){
  tab   <- tab > 0
  ncol  <- ncol(tab)
  i     <- rev(seq_len(nrow(tab)))
  if (newplot) plot.new()
  graphics::image(t(tab[i, , drop = FALSE]), axes = FALSE, col = col)
  if (!is.null(f)) {
    if (is.character(f)) {
      f <- factor(f, levels = unique(f))
    }
    loci  <- which(!duplicated(f))
    ticks <- midpoints(c(loci - 1, ncol))/ncol
    graphics::abline(v = c((loci - 1.5)/(ncol - 1), 1 + (0.5/(ncol - 1))), lwd = 2, col = "grey97")
    graphics::axis(1, at = ticks, labels = levels(f), las = 3, tick = FALSE, padj = 0)
  }
  if (!is.null(highlight)) {
    if (is.character(highlight)) {
      tab2 <- tab
      tab2[!rownames(tab) %in% highlight, ] <- NA
      graphics::image(t(tab2[i, , drop = FALSE]), add = TRUE, axes = FALSE, col = idcol)
    }
  }
  invisible(NULL)
}

# A function to calculate the midpoints of a numeric vector
# if you supply 1 3 and 5, it will give 2 and 4
midpoints <- function(x) x[-length(x)] + (x[-1] - x[-length(x)])/2
