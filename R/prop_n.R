#' Proportion and Count of a Specific Value
#'
#' Calculates the percentage and count of a specific value in a vector and returns it as a formatted string.
#'
#' @param variable A vector (numeric, character, or factor).
#' @param value_of_interest The value to count.
#' @param rounding_value Number of decimal places to round the percentage to.
#'
#' @return A character string formatted as "x% (n = y)".
#'
#' @importFrom dplyr n
#'
#' @export
prop_n <- function(variable, value_of_interest, rounding_value) {
	percentage <- round(
		(sum(variable == value_of_interest, na.rm = TRUE) / n()) * 100,
		rounding_value
	)
	event_count <- sum(variable == value_of_interest, na.rm = TRUE)
	result <- paste0(percentage, "% (n = ", event_count, ")")
	return(result)
}
