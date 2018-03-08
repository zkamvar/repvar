#' repvar.
#'
#' This package allows you to find the minimum set of samples that represents
#' all non-zero variables in a binary matrix.
#'
#' Minimum set of samples can be found with the function [rpv_find()]. This
#' function will shuffle your data set and pass it to [rpv_indices()]. From
#' this, you will have a list of sample names.
#'
#' Because there may be several combinations of samples that represent all
#' variables, the function [rpv_stats()] can be used to calculate entropy
#' statistics over these variables.
#'
#' @name repvar
#' @docType package
#' @importFrom stats na.omit
NULL
