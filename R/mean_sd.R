#' Mean and Standard Deviation Summary
#'
#' Returns a formatted string showing the mean and standard deviation of a numeric vector.
#'
#' @param x A numeric vector.
#'
#' @return A character string formatted as "mean (SD)".
#' @export
mean_sd <- function(x) {
	a <- mean(x, na.rm = TRUE)
	b <- sd(x, na.rm = TRUE)
	result <- paste(a, " (", b, ")")
	return(result)
}
