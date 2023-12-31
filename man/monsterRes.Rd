% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MONSTER.R
\docType{data}
\name{monsterRes}
\alias{monsterRes}
\title{MONSTER results from example cell-cycle yeast transition}
\format{
MONSTER obj
#' @references Schlauch, Daniel, et al. "Estimating drivers of cell state transitions using gene regulatory network models." BMC systems biology 11.1 (2017): 1-10.
}
\usage{
data(monsterRes)
}
\description{
This data contains the MONSTER result from analysis of Yeast Cell cycle, included in data(yeast).  
This result arbitrarily takes the first 20 gene expression samples in yeast$cc to be the baseline condition, and the final 20 samples to be the final condition.
}
\keyword{datasets}
