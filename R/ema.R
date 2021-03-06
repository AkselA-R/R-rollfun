################################################################################

#' Exponential Moving Average
#' 
#' \code{ema} returns a vector whose values are the 
#' exponentially smoothed values of the input vector
#' 
#' @param x a numeric vector
#' @param a smoothing factor
#'
#' @details With \eqn{Y_t}{Y[t]} being the input at time \eqn{t},
#' \eqn{S_t}{S[t]} being the output at time \eqn{t}, and
#' \eqn{\alpha = 1/a} \cr – the function can be defined like this:
#' 
#' \deqn{S_t =\left\{\begin{array}{lr}
#' Y_1,                                           & t = 1 \\ 
#' \alpha \cdot Y_t + (1 - \alpha) \cdot S_{t-1}, & t > 1
#' \end{array}\right.}{
#'   S[t] = \{Y[1] for t = 1;
#'   \alpha * Y[t] + (1 - \alpha) * S[t-1] for t > 1\}}
#' 
#' The function is also sometimes referred to as an 
#' exponentially weighted moving average (EWMA).
#' 
#' 
#' 
#' @export
#' @examples
#' x <- c(rep(0, 4), 1, rep(0, 59))
#' a <- 1:10*5
#' col <- rainbow(length(a), start=0.15)
#' 
#' plot(x, type="p", pch=16, cex=0.4, ylim=c(0, 0.21), xaxs="i",
#'   main="Exponential Moving Average", xlab="Time", ylab="Magnitude")
#' for (i in seq_along(a)) {
#'     lines(ema(x, a[i]), col=col[i])
#' }
#' 
#' mtext("Single impulse of magnitude 1 occuring at time = 5", line=0.2)
#' L <- lapply(seq_along(a), function(x) bquote(alpha ==  1 / .(a[x])))
#' legend("topright", legend=as.expression(L),
#'   bty="n", col=col, lwd=1.2, cex=0.8, y.intersp=1.2)

ema <- function(x, a=2) {
    x <- c(x[1], x)
    a <- 1/a
    for (i in 2:length(x)) {
        x[i] <- (1-a)*x[i-1] + a*x[i]
    }
    x[-1]
}

# roxcomm()