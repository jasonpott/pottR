#' Proportion and Count of Values Greater Than or Equal to a Threshold
#'
#' Calculates the percentage and count of values greater than or equal to a specified threshold.
#'
#' @param variable A numeric vector.
#' @param value_of_interest A numeric threshold.
#' @param rounding_value Number of decimal places to round the percentage to.
#'
#' @return A character string formatted as "x% (n = y)".
#' @export
prop_n_greater <- function(variable, value_of_interest, rounding_value) {
	percentage <- round(
		(sum(as.numeric(variable) >= as.numeric(value_of_interest), na.rm = TRUE)) /
			length(variable) *
			100,
		rounding_value
	)
	event_count <- sum(
		as.numeric(variable) >= as.numeric(value_of_interest),
		na.rm = TRUE
	)
	result <- paste0(percentage, "% (n =", event_count, ")")
	return(result)
}
