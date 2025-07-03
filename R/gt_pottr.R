#' Style a `gt` Table with Custom Formatting
#'
#' Applies standardized formatting to a `gt` table, including font size, padding,
#' column title formatting, number rounding, character string percentage formatting,
#' and an optional footnote.
#'
#' @param gt_tbl A `gt` table object to be styled.
#' @param footnote Optional character string. If provided, it is added as a footnote to the table title.
#'
#' @details
#' This function performs the following actions:
#' \itemize{
#'   \item Sets font style to Calibri and font size to 12.
#'   \item Applies uniform padding to table elements.
#'   \item Converts column names to sentence case and replaces underscores with spaces.
#'   \item Rounds numeric columns to 1 decimal place.
#'   \item Finds and formats percentages inside character columns to 1 decimal place using regex.
#'   \item Optionally adds a footnote to the table title.
#' }
#'
#' @return A `gt` table object with custom styling applied.
#'
#' @importFrom gt tab_options tab_footnote cols_label fmt_number fmt cells_title px
#' @importFrom dplyr where
#' @importFrom tools toTitleCase
#'
#' @export
gt_pottr <- function(gt_tbl, footnote = NULL) {
	# Format column labels: replace underscores and convert to sentence case
	col_labels <- names(gt_tbl[["_data"]])
	new_labels <- gsub("_", " ", col_labels) |>
		tools::toTitleCase() |>
		gsub("([A-Z])", "\\L\\1", ., perl = TRUE) |>
		gsub("^(\\w)", "\\U\\1", ., perl = TRUE)
	names(new_labels) <- col_labels

	gt_tbl <- gt_tbl |>
		gt::cols_label(.list = as.list(new_labels)) |>

		# Format numeric columns to 1 decimal
		gt::fmt_number(
			columns = dplyr::where(is.numeric),
			decimals = 1
		)

	# Conditionally format character columns with embedded percentages
	if (any(vapply(gt_tbl[["_data"]], is.character, logical(1)))) {
		gt_tbl <- gt_tbl |>
			gt::fmt(
				columns = dplyr::where(is.character),
				fns = function(x) {
					gsub(
						"(\\d+\\.?\\d*)%",
						function(m) {
							val <- round(as.numeric(sub("%", "", m)), 1)
							paste0(val, "%")
						},
						x
					)
				}
			)
	}

	# Apply table styling
	gt_tbl <- gt_tbl |>
		gt::tab_options(
			table.font.size = 12,
			table.font.style = "calibri",
			data_row.padding = gt::px(1),
			summary_row.padding = gt::px(2),
			grand_summary_row.padding = gt::px(1),
			footnotes.padding = gt::px(1),
			source_notes.padding = gt::px(1),
			row_group.padding = gt::px(1),
			row_group.font.weight = "bold"
		)

	# Add footnote if supplied
	if (!is.null(footnote)) {
		gt_tbl <- gt_tbl |>
			gt::tab_footnote(
				footnote = footnote,
				locations = gt::cells_title(groups = "title")
			)
	}

	return(gt_tbl)
}
