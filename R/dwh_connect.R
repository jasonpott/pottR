#' Connect to the Data Warehouse
#'
#' This function establishes an ODBC connection to the specified SQL Server data warehouse.
#'
#' @param x A character string specifying the name or address of the SQL Server.
#'   Defaults to the value of the environment variable `"TRUST_DWH"`.
#'
#' @return A database connection object of class `DBIConnection`, which can be used
#'   with `DBI` and `dbplyr` functions to query the data warehouse.
#'
#' @examples
#' \dontrun{
#' con <- dwh_connect()
#' dbListTables(con)
#' }
#'
#' @importFrom odbc dbConnect odbc
#'
#' @export
dwh_connect <- function(x = Sys.getenv("TRUST_DWH")) {
	con <- odbc::dbConnect(
		odbc::odbc(),
		Driver = "ODBC Driver 17 for SQL Server",
		Trusted_Connection = "Yes",
		Server = x,
	)
	return(con)
}
