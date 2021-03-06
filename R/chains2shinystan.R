chains2shinystan <- function(chain_list, ...) {
#   chain_list: a list of 2D-arrays or matrices of iterations (rows) and
#   parameters (columns). each chain in chain_list should have the same number
#   of iterations and the same parameters (with the same names and in the same
#   order)

  if (!is.list(chain_list)) {
    name <- deparse(substitute(chain_list))
    stop (paste(name, "is not a list."))
  }

  nChain <- length(chain_list)
  if (nChain > 1) {
    nIter <- sapply(chain_list, nrow)
    same_iters <- length(unique(nIter)) == 1
    if (!same_iters) stop("Each chain should contain the same number of iterations.")

    cnames <- sapply(chain_list, colnames)
    if (is.array(cnames)) {
      same_params <- identical(cnames[,1], cnames[,2])
      param_names <- cnames[,1]
    } else {
      same_params <- length(unique(cnames)) == 1
      param_names <- cnames
    }
    if (!same_params) stop("The parameters for each chain should be in the same order and have the same names.")

    nIter <- nIter[1]
  } else {
    if (nChain == 1) {
      nIter <- nrow(chain_list[[1]])
      param_names <- colnames(chain_list[[1]])
    } else {
      stop("You don't appear to have any chains.")
    }
  }

  param_names <- unique(param_names)
  nParam <- length(param_names)

  out <- array(NA, dim = c(nIter, nChain, nParam))
  for(i in 1:nChain) {
    out[,i,] <- chain_list[[i]]
  }

  dimnames(out) <- list(iterations = NULL,
                        chains = paste0("chain:",1:nChain),
                        parameters = param_names)

  out <- array2shinystan(out, ...)
  out
}
