#' Retrieve a SQL table with columns ordered by data type
#'
#' This function queries the column information of a given SQL Server table,
#' sorts the columns by data type (descending), and returns a `dplyr::tbl` with
#' columns reordered accordingly. This can be useful when visually scanning
#' wide tables by prioritizing text columns first.
#'
#' @param con A database connection object, typically from `odbc::dbConnect()`.
#' @param table A character string specifying the name of the table to query.
#'
#' @return A `tbl` object representing the remote table with columns ordered by data type.
#'
#' @importFrom dplyr arrange pull select tbl desc
#' @importFrom tidyselect all_of
#' @importFrom odbc dbSendQuery dbColumnInfo
#'
#' @export
tbl_long_cols <- function(con, table) {
	res <- DBI::dbSendQuery(con, paste0("SELECT * FROM ", table))
	on.exit(DBI::dbClearResult(res))
	cols_sorted <- odbc::dbColumnInfo(res) |>
		dplyr::arrange(dplyr::desc(type)) |>
		dplyr::pull(name)
	return(cols_sorted)
}
