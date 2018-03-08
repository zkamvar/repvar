#==============================================================================#
#' Peach brown rot pathogen *Monilinia fructicola*
#'
#' @name monilinia
#' @docType data
#' @usage data(monilinia)
#' @description This is clone-censored microsatellite data for a population of the haploid
#'   plant pathogen *Monilinia fructicola* that causes disease within peach
#'   tree canopies (Everhart & Scherm, 2014). Entire populations within trees
#'   were sampled across 3 years (2009, 2010, and 2011) in a total of four
#'   trees, where one tree was sampled in all three years, for a total of 6
#'   within-tree populations. Within each year, samples in the spring were taken
#'   from affected blossoms (termed "BB" for blossom blight) and in late summer
#'   from affected fruits (termed "FR" for fruit rot). From a total of 694
#'   isolates, this data set represents 264 unique genotypes characterized uzing
#'   a set of 13 microsatellite markers comprised of 95 alleles.
#' @format an integer matrix where rows represent individual samples and columns
#'   represent alleles at different loci where the locus name and fragment size
#'   are separated by a period.
#' @references SE Everhart, H Scherm, (2015) Fine-scale genetic structure of
#'   *Monilinia fructicola* during brown rot epidemics within individual
#'   peach tree canopies. *Phytopathology* **105**:542-549 doi:
#'   [10.1094/PHYTO-03-14-0088-R](http://dx.doi.org/10.1094/PHYTO-03-14-0088-R)
#'
#' @examples
#' data(monilinia)
#' (i <- rpv_indices(monilinia))
"monilinia"
