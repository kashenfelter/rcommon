% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gibbs.R
\name{gibbs}
\alias{gibbs}
\title{Generic Gibbs sampler}
\usage{
gibbs(init, update, B, burn)
}
\arguments{
\item{init:}{list of parameters and initial values
e.g.: list("mu"=0,"sig2"=1)}

\item{update:}{a function that updates parameters
takes as input the current state (list like init)
returns the updated state}

\item{B:}{number of MCMC samples}

\item{burn:}{burn-in}
}
\description{
Generic Gibbs sampler
}
\examples{
n <- 1000
y <- rnorm(n,5,sqrt(2))
ybar <- mean(y)

update <- function(params) {
  newMu <- rnorm(1,ybar,sqrt(params$sig2/n))
  newSig2 <- 1 / rgamma(1,2+n/2,1+sum((y-newMu)^2)/2)
  list("mu"=newMu,"sig2"=newSig2)
}

system.time( # R: .229, Scala: .48, Julia: .139
  out <- gibbs(list("mu"=0,"sig2"=1),update,10000,1000)
)

postMu <- sapply(out,function(o) o$mu)
postSig2 <- sapply(out,function(o) o$sig2)

plotPosts(cbind(postMu,postSig2))

}
