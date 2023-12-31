% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ALPACA.R
\name{alpacaComputeDWBMmatmScale}
\alias{alpacaComputeDWBMmatmScale}
\title{Differential modularity matrix}
\usage{
alpacaComputeDWBMmatmScale(edge.mat, ctrl.memb)
}
\arguments{
\item{edge.mat}{A table of edges, with the first column representing the TFs ("from" nodes) and the second column representing the targets ("to" nodes). The third column contains the edge weights corresponding to the control or healthy network, and the fourth column contains the edge weights for the disease network or network of interest.}

\item{ctrl.memb}{The community membership for the control (healthy) network.}
}
\value{
The differential modularity matrix, with rows representing "from" nodes and columns representing "to" nodes.
}
\description{
This function computes the differential modularity matrix for weighted bipartite networks. The community structure of the healthy network is rescaled by the ratio of m (the total edge weight) of each network.
}
\examples{
a <- 1 # place holder
}
