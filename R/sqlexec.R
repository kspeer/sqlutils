#' Executes the specified query and returns a data frame. This function currently
#' supports RODBC, RSQLite, and RMySQL. For other databases, use getQuery() and
#' execute the SQL statement using the appropriate database connection.
#' 
#' @param query the query to execute.
#' @param connection the database connection.
#' @param maxLevels the maximum number of levels a factor can have before being
#'        converted to a character.
#' @param ... other parameters passed to \code{\link{getSQL}} and \code{\link{sqlexec}}.
#' @seealso sqlexec, cacheQuery
#' @export
execQuery <- function(query=NULL, connection=NULL, maxLevels=20, ...) {
	sql = getSQL(query=query, ...)
	df <- sqlexec(connection, sql=sql, ...)
	return(recodeColumns(df, maxLevels))
}

#' Recodes factors with more than \code{maxLevels} to characters.
#' @param df the data frame to recode.
#' @param maxLevels the maximum number of levels a factor can have before being
#'        converted to a character.
recodeColumns <- function(df, maxLevels=20) {
	for(c in 1:ncol(df)) {
		if(class(df[,c])[1] == 'factor' & length(levels(df[,c])) > maxLevels) {
			df[,c] = as.character(df[,c])
		}
	}
	return(df)	
}

#' Generic function for executing a query.
#' 
#' @param connection the database connection.
#' @param sql the query to execute.
#' @param ... other parameters passed to the appropriate \code{sqlexec} function.
#' @return a data frame.
#' @export sqlexec
sqlexec <- function(connection, sql, ...) { UseMethod("sqlexec") }

#' Executes queries for RODBC package.
#' 
#' @param connection the database connection.
#' @param sql the query to execute.
#' @param ... other parameters passed to the appropriate \code{sqlexec} function.
#' @return a data frame.
#' @method sqlexec RODBC
#' @S3method sqlexec RODBC
#' @export
sqlexec.RODBC <- function(connection, sql, ...) {
	sqlQuery(connection, sql) #TODO: Why doesn't this work with ... passed through
}

#' Executes queries for RSQLite package.
#' 
#' @param connection the database connection.
#' @param sql the query to execute.
#' @param ... other parameters passed to the appropriate \code{sqlexec} function.
#' @return a data frame.
#' @method sqlexec SQLiteConnection
#' @S3method sqlexec SQLiteConnection
#' @export
sqlexec.SQLiteConnection <- function(connection, sql, ...) {
	dbGetQuery(connection, sql, ...)
}

#' Executes queries for RMySQL package.
#' 
#' @param connection the database connection.
#' @param sql the query to execute.
#' @param ... other parameters passed to the appropriate \code{sqlexec} function.
#' @return a data frame.
#' @method sqlexec RMySQL
#' @S3method sqlexec RMySQL
#' @export
sqlexec.RMySQL <- function(connection, sql, ...) {
	dbSendQuery(connection, sql, ...)
}
