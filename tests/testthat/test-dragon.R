# unit-tests for DRAGON
context("test DRAGON helper functions")

test_that("[DRAGON] scale() function yields expected results", {
  x = seq(1:100)
  scale_unbiased = scale(x) # default is bias=F
  expect_equal(sd(scale_unbiased),1,tolerance = 1e-15)
  
  xbar = mean(x)
  xstd_bias = sqrt(1/length(x)*sum((x-xbar)^2))
  
  # calculate the unbiased standard deviation of the vector scaled
  # using the biased standard deviation. It will be slightly off from 1
  biased_sd_hand = sqrt(1/(length(x)-1)*sum(((x-xbar)/xstd_bias)^2))
  
  scale_biased = scale(x,bias=T)
  expect_equal(sd(scale_biased),biased_sd_hand, tolerance = 1e-15)
})

test_that("[DRAGON] VarS() function yields expected results", {
  myX = matrix(c(1,2,9,3,1,7,5,12,8),byrow=T,ncol=3)
  # gold standard calculated from DRAGON in netZooPy
  pyVarS = matrix(c(4,37,1,37,342.25,9.25,1,9.25,0.25),byrow=T,ncol=3)
  expect_equal(VarS(myX),pyVarS, tolerance=1e-15)
}
)

test_that("[DRAGON] EsqS() function yields expected results", {
  myX = matrix(c(1,2,9,3,1,7,5,12,8),byrow=T,ncol=3)
  # gold standard calculated from DRAGON in netZooPy
  pyEsqS = matrix(c(16,100,1,100,1369,0.25,1,0.25,1),byrow=T,ncol=3)
  expect_equal(EsqS(myX),pyEsqS, tolerance=1e-15)
}
)

test_that("[DRAGON] risk() function calculates correct risk",{
  Gamma1 = 1.1
  Gamma2 = 2
  T11 = 3
  T12 = 4
  T21 = 5
  T22 = 6
  T3 = 7
  T4 = 8
  const = 1
  
  # manual calc
  R_hand = 1+(1-Gamma1^2)*T11 + (1-Gamma2^2)*T12 + 
    (1-Gamma1^2)^2*T21 +(1-Gamma2^2)^2*T22 +
    (1-Gamma1^2)*(1-Gamma2^2)*T3 + 
    Gamma1*Gamma2*T4
  R = risk(c(Gamma1,Gamma2),const,T11,T12,T21,T22,T3,T4)
  expect_equal(R,R_hand, tolerance = 1e-15)
}
)

test_that("[DRAGON] get_shrunken_covariance_dragon() function returns the right values",{
  # confirm that matches python results  
  myX = matrix(c(1,2,9,3,1,7,5,12,8),byrow=T,ncol=3)
  X1 = as.matrix(myX[,1:2])
  X2 = as.matrix(myX[,3])
  lambdas = c(0.25,0.5)
  res = get_shrunken_covariance_dragon(X1,X2,lambdas)
  res_py = as.matrix(read.csv("./dragon_test_get_shrunken_covariance.csv",row.names=1))
  expect_equal(as.vector(res),as.vector(res_py),tolerance = 1e-15) 
}
)

test_that("[DRAGON] Risk grid in netZooR impl. matches risk grid from netZooPy impl.",
{
  toy_layer1 = matrix(c(1,2,3,1,5,12),nrow=3,byrow=T)
  toy_layer2 = matrix(c(9,7,8),nrow=3,byrow=T)

  res = dragon(layer1 = toy_layer1, layer2 = toy_layer2, pval = F)
  # assert risk results are equal on toy data 
  risk_py = read.csv("risk_grid_netzoopy.csv",header=F)
  expect_equal(as.vector(t(res$risk_grid)), as.vector(as.matrix(risk_py)),tolerance = 1e-10)
})

# test dragon() exported function
test_that("[DRAGON] dragon() exported function works on simulated data",
{
  # load dragon data simulated from python 
  toy_layer1 = read.csv("dragon_layer1.csv",header=F)
  toy_layer2 = read.csv("dragon_layer2.csv",header=F)
  res = dragon(layer1 = toy_layer1, layer2 = toy_layer2, pval = F)
  
  # assert tuning parameter results are equal to that found with python 
  python_lambda1 = 0.9074582855371163
  python_lambda2 = 0.9132919090041549
  
  # These are the same 1e-5  
  expect_equal(res$lambdas[1],python_lambda1,tol=1e-5)
  expect_equal(res$lambdas[2],python_lambda2,tol=1e-5)
  
  # assert that output matrices are the same within this tolerance
  py_cov = read.csv("dragon_python_cov.csv",header=F)
  expect_equal(as.vector(res$cov),as.vector(as.matrix(py_cov)),tol=1e-5)
  
  # confirm the inversion matches to machine zero in R
  expect_equal(as.vector(solve(res$cov)),as.vector(res$prec),tol=1e-15)
  
  # because of the propagation of differences that comes along with
  # matrix inversion, we see bigger differences in the precision and ggm matrices
  # tolerance of 1e-2
  
  py_prec = read.csv("dragon_python_prec.csv",header=F)
  expect_equal(as.vector(res$prec),as.vector(as.matrix(py_prec)),tol=1e-2)
  
  py_parcor = read.csv("dragon_python_parcor.csv",header=F)
  expect_equal(as.vector(res$ggm),as.vector(as.matrix(py_parcor)),tol=1e-2)

})

# test log likelihood function
# test_that("[DRAGON] Log likelihood function for estimation of kappa is correct",{
#   # log_lik_shrunken = function(kappa, p, lambda, rhos)
#   kappa = 10
#   p = 100
#   lambda = 0.1
#   rhos = runif(n = 100, min = -0.9, max = 0.9) # equation is valid for [-(1-lambda),(1-lambda)]
#   log_lik_shrunken(kappa = kappa, 
#                    p = p,
#                    lambda = lambda,
#                    rhos = rhos)
# })

#testing format
#test_that(,{})
