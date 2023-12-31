#' Turn PANDA network into a CONDOR object
#'
#' \strong{CONDOR} (COmplex Network Description Of Regulators) implements methods for clustering biapartite networks
#' and estimatiing the contribution of each node to its community's modularity, 
#' \href{http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005033}{[(Platig et al. 2016)])}
#' This function uses the result of PANDA algorithm as the input dataset to run CONDOR algorithm. More about \href{https://github.com/jplatig/condor}{condor} package and usage.
#'  
#' @param panda.net Data Frame indicating the result of PANDA regulatory network, created by \code{\link{pandaPy}}
#' @param threshold Numeric vector of the customered threshold to select edges. Default value is the the midpoint between 
#' the median edge-weight of prior ( 3rd column "Motif" is 1.0) edges 
#' and the median edge-weight of non-prior edges (3rd column "Motif" is 0.0) in PANDA network.
#' and the median edge-weight of non-prior edges (3rd column "Motif" is 0.0) in PANDA network.
#' 
#' @return a CONDOR object, see \code{\link{createCondorObject}}.
#' @import viridisLite
#' @examples 
#' 
#' # refer to three input datasets files in inst/extdat
#' treated_expression_file_path <- system.file("extdata", "expr4_matched.txt", 
#' package = "netZooR", mustWork = TRUE)
#' motif_file_path <- system.file("extdata", "chip_matched.txt", package = "netZooR", mustWork = TRUE)
#' ppi_file_path <- system.file("extdata", "ppi_matched.txt", package = "netZooR", mustWork = TRUE)
#' 
#' 
#' # Run PANDA to construct the treated network
#' \donttest{
#' treated_all_panda_result <- pandaPy(expr_file = treated_expression_file_path, 
#' motif_file= motif_file_path, ppi_file = ppi_file_path, 
#' modeProcess="legacy", remove_missing = TRUE )
#' 
#' # access PANDA regulatory network
#' treated_net <- treated_all_panda_result$panda
#' 
#' # Obtain the condor.object from PANDA network
#' treated_condor_object <- pandaToCondorObject(treated_net, threshold = 0)
#' 
#' # cluster condor.object
#' treated_condor_object <- condorCluster(treated_condor_object, project = FALSE)
#' 
#' # package igraph and package viridisLite are already loaded with this package.
#' library(viridisLite)
#' treated_color_num <- max(treated_condor_object$red.memb$com)
#' treated_color <- viridis(treated_color_num, alpha = 1, begin = 0, end = 1, 
#' direction = 1, option = "D")
#' condorPlotCommunities(treated_condor_object, color_list=treated_color, 
#' point.size=0.04, xlab="Target", ylab="Regulator")
#' }
#' 
#' @export
#'

pandaToCondorObject <- function(panda.net, threshold){
  # *** SELECT EDGE ***
  # if the threshold (cutoff) of edge-weight is undefined.
  if (missing(threshold)){
    
    # Add an additional column storing the transforming edge weights by formula w'=ln(e^w+1)
    panda.trans <- data.frame(panda.net, Score_Trans=log(exp(panda.net$Score)+1))
    
    # the median of prior edges and non-prior edges
    # midway of these two medians.
    threshold <- 1/2 * (median(panda.trans[panda.trans$Motif == 1,'Score_Trans']) + median(panda.trans[panda.trans$Motif == 0,'Score_Trans']))
  
    message("Using the mean of [median weight of non-prior edges] and [median weight of prior edges], 
            all weights mentioned here are transformationed with formula w'=ln(e^w+1) from the original PANDA network edge weight")
    # retain the TF, Gene and original Score columns
    panda.trans <- panda.trans[panda.trans$Score_Trans >= threshold,c('TF',"Gene","Score")]
    }
  
  # if the threshold (cutoff) of edge-weight is provided. 
  # when the customed threshold is out of range, print out error message.
   if (threshold > max(panda.net$Score) || threshold < min(panda.net$Score) ) {
    stop("Please provide the edge-weight threshold between ", min(panda.net$Score)," and ", max(panda.net$Score))
  }
  else {
    panda.trans <- panda.net[panda.net$Score >= threshold, c('TF',"Gene","Score")]
  }
  
  # *** create condor.object ***
  n_reg <- length(unique(panda.trans$TF))
  n_tar <- length(unique(panda.trans$Gene))
  if(n_reg < n_tar) {
    condor.object <- createCondorObject(panda.trans[,c("Gene","TF")])
  } else { condor.object <- createCondorObject( panda.trans[,c("TF","Gene")] )}
  
  colnames(condor.object$edges)[c(1,2)] <- c ("red","blue")

  return(condor.object)
}



