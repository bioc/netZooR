% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ALPACA.R
\name{alpacaCommunityStructureRotation}
\alias{alpacaCommunityStructureRotation}
\title{Comparing node community membership between two networks}
\usage{
alpacaCommunityStructureRotation(net1.memb, net2.memb)
}
\arguments{
\item{net1.memb}{The community membership for Network 1.}

\item{net2.memb}{The community membership for Network 2.}
}
\value{
A ranked list of nodes.
}
\description{
This function uses the pseudo-inverse to find the optimal linear transformation mapping the community structures of two networks, then ranks nodes in the network by how much they deviate from the linear mapping.
}
\examples{
a <- 1 #place holder
}
