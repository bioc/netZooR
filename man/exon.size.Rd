% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SAMBAR.R
\docType{data}
\name{exon.size}
\alias{exon.size}
\title{Gene length}
\format{
A integer vector of size 23459, with gene symbols as names

A list containing Exon sizes for 23459 genes

A vector containing names of 23459 genes
}
\usage{
data(exon.size)

data(exon.size)

data(genes)
}
\value{
A list of length 1

A vector of length 23459
}
\description{
A vector of gene lengths. This will be used to normalize the gene mutation scores by the gene's length. This example is based on hg19 gene symbols. The gene length is based on the number of non-overlapping exons.
Data were downloaded and pre-processed as described in
\href{https://doi.org/10.1101/228031}{Kuijjer et al.}

This data is a toy example data for SAMBAR, it contains length of Exons.

This data is a toy example data for SAMBAR, it contains gene annotations
}
\references{
Kuijjer, Marieke Lydia, et al. "Cancer subtype identification using somatic mutation data." British journal of cancer 118.11 (2018): 1492-1501.

Kuijjer, Marieke Lydia, et al. "Cancer subtype identification using somatic mutation data." British journal of cancer 118.11 (2018): 1492-1501.
}
\keyword{datasets}
