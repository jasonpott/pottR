#' Append NOLOCK hint to SQL table reference
#'
#' This helper function appends the SQL Server `WITH (NOLOCK)` hint to a table
#' reference string, which can be used in `dbplyr::tbl()` calls to allow reading
#' data without locking.
#'
#' @param table_name A character string representing the full name of the table
#' (e.g., `"schema.database.table"`).
#'
#' @return A character string of the form `schema.database.table WITH (NOLOCK)`.
#'
#' @examples
#' with_no_lock("BH_DATAWAREHOUSE.dbo.PI_CDE_PERSON_PATIENT")
#' # Returns: "BH_DATAWAREHOUSE.dbo.PI_CDE_PERSON_PATIENT WITH (NOLOCK)"
#'
#' @importFrom dbplyr sql
#'
#' @export
with_no_lock <- function(table_name) {
	return(dbplyr::sql(paste("SELECT * FROM", table_name, "WITH (NOLOCK)")))
}
