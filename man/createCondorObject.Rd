% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CONDOR.R
\name{createCondorObject}
\alias{createCondorObject}
\title{Create list amenable to analysis using \code{condor} package.}
\usage{
createCondorObject(edgelist, return.gcc = TRUE)
}
\arguments{
\item{edgelist}{a data.frame with 'red' nodes in the first column and
'blue' nodes in the second column, representing links from the node in
the first column to the node in the second column. There must be more
unique 'red' nodes than 'blue' nodes. Optionally, a third column may be
provided to create a weighted network.}

\item{return.gcc}{if TRUE, returns the giant connected component}
}
\value{
G is an igraph graph object with a 'color' attribute
based on the colnames of edgelist. This can be accessed via
V(g)$color, which returns a vector indicating red/blue. Use V(g)$name
with V(g)$color to identify red/blue node names

edges corresponding to graph G. If return.gcc=TRUE, includes only
those edges in the giant connected component.

Qcoms output from \code{\link{condorCluster}} or 
\code{\link{condorModularityMax}}

modularity \code{NULL} output from \code{\link{condorCluster}} 
or \code{\link{condorModularityMax}}

red.memb \code{NULL} output from \code{\link{condorCluster}} 
or \code{\link{condorModularityMax}}

blue.memb \code{NULL} output from \code{\link{condorCluster}} 
or \code{\link{condorModularityMax}}

qscores \code{NULL} output from \code{\link{condorQscore}}
}
\description{
Converts an edge list into a \code{list} which is then an input for 
other functions in the \code{condor} package.
}
\examples{
r = c(1,1,1,2,2,2,3,3,3,4,4);
b = c(1,2,3,1,2,4,2,3,4,3,4);
reds <- c("Alice","Sue","Janine","Mary")
blues <- c("Bob","John","Ed","Hank")
elist <- data.frame(red=reds[r],blue=blues[b])
condor.object <- createCondorObject(elist)

}
