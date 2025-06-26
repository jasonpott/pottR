#' Retrieve Column Names Ordered by SQL Data Type
#'
#' This function queries the metadata of a given SQL Server table and returns a character
#' vector of column names, ordered by their data type in descending order. This can be useful
#' for controlling column selection or ordering in downstream queries (e.g., placing long text
#' columns last).
#'
#' @param con A database connection object, typically created with `odbc::dbConnect()`.
#' @param table A character string specifying the name of the SQL table to query.
#'
#' @return A character vector of column names ordered by data type.
#'
#' @importFrom dplyr arrange pull desc
#' @importFrom odbc dbSendQuery dbColumnInfo
#' @importFrom DBI dbClearResult
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
