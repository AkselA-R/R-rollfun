norma <- function(W, c=0, r=2) {
    (W - min(W, na.rm=TRUE)) * (r/(max(W, na.rm=TRUE) - min(W, na.rm=TRUE))) - r/2 + c
}

fitrange <- function(W, lower=-1, upper=1) {
	if(lower>upper) warning("upper bound must be strictly larger than lower bound")
	newrange <- upper - lower
	oldrange <- max(W, na.rm=TRUE) - min(W, na.rm=TRUE)
	(W - min(W, na.rm=TRUE)) * (newrange/oldrange) + lower
}

fade <- function(x, fin=c(0, 10, 15), fout=fin) {
	
    if (is.matrix(x) || is.data.frame(x)) {
    	lx <- nrow(x)
    } else lx <- length(x)
    
    iter <- 5
    if (lx > 3000) iter <- 4
    if (lx > 5000) iter <- 3
	
	fin_seq   <- rolliter(c(rep(fin[1], fin[2]), 
	                       rep(1, lx-fin[2])), 
                         fin[3], iter, TRUE, FALSE)
    fin_seq   <- fitrange(fin_seq, fin[1], 1)

	fout_seq <- rolliter(c(rep(1, lx-fout[2]), 
	                       rep(fout[1], fout[2])), 
                         fout[3], iter, TRUE, FALSE)
    fout_seq <- fitrange(fout_seq, fout[1], 1)
    
    x * fout_seq * fin_seq
}

# set.seed(1)
# r <- rnorm(200)
# plot(r, type="l")
# lines(fade(r), col="red", lwd=1.5)