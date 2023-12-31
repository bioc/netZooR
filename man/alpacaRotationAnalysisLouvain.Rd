% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ALPACA.R
\name{alpacaRotationAnalysisLouvain}
\alias{alpacaRotationAnalysisLouvain}
\title{Community comparison method (CONDOR optimizaton)}
\usage{
alpacaRotationAnalysisLouvain(net.table)
}
\arguments{
\item{net.table}{A table of edges, with the first column representing the TFs ("from" nodes) and the second column representing the targets ("to" nodes). The third column contains the edge weights corresponding to the control or healthy network, and the fourth column contains the edge weights for the disease network or network of interest.}
}
\value{
Vector of nodes ordered by how much they change their community membership between the two networks.
}
\description{
Takes two networks, finds community structure of each one individually using a generalization of the Louvain method, and then ranks the nodes that show the biggest difference in their community membership.
}
\examples{
a <- 1 # example place holder
}
