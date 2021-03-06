% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/visualization.R
\name{rpv_image}
\alias{rpv_image}
\title{Create an image of the data matrix}
\usage{
rpv_image(tab, f = NULL, highlight = NULL, newplot = TRUE,
  col = c("#A6CEE3", "#1F78B4"), idcol = c("#FFFF99", "#B15928"))
}
\arguments{
\item{tab}{a numeric matrix}

\item{f}{a factor that is the same length as the number of columns in \code{tab}.
this is used to split the matrix up by groups for analysis.}

\item{highlight}{a character vector specifing which row names or indices to
highlight.}

\item{newplot}{When \code{TRUE} (default), The image will not over-write the
previous image. Turn this off if you want to use multi-panel plotting.}

\item{col}{a two-color vector for the values of the matrix.}

\item{idcol}{a two-color vector for the highlight values.}
}
\value{
NULL, invisibly
}
\description{
Create an image of the data matrix
}
\details{
This function creates a plot that will allow you to visualize a
matrix, optionally overlaying data. Note: the values here represent the
presence/absence of a variable, but does not represent the dosage.
}
\examples{
data(monilinia)
loci <- sapply(strsplit(colnames(monilinia), "[.]"), "[", 1)
rpv_image(monilinia, f = loci)
rpv_image(monilinia, f = loci, highlight = rpv_indices(monilinia))
}
