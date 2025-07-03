#' Median and IQR Summary
#'
#' Returns a formatted string showing the median and interquartile range (IQR) of a numeric vector.
#'
#' @param x A numeric vector.
#'
#' @return A character string formatted as \code{"median [Q1 - Q3]"}.
#'
#' @export
med_iqr <- function(x) {
	a <- median(x, na.rm = TRUE)
	b <- quantile(x, na.rm = TRUE, 0.25)
	c <- quantile(x, na.rm = TRUE, 0.75)
	result <- paste(a, " [", b, " - ", c, "]")
	return(result)
}
