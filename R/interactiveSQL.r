#' Interactive SQL session.
#' 
#' This function will start an interactive SQL session. The user can enter SQL
#' statements and execute them against the given database connection. This was
#' initially developed as a teaching tool for learning SQL.
#' 
#' @param conn a database connection.
#' @param sql initial SQL statement.
#' @param ... other parameters passed to \code{\link{sqlexec}}.
#' @return returns the last entered SQL statement.
#' @export
isql <- function(conn, sql = character(), ...) {
	cat('Interactive SQL mode (type quit to exit, help for available commands)...\n')
	
	df <- NULL

	cat("SQL>"); line <- readLines(n=1)
	while(line != 'quit' & line != 'exit') {
		if(line == 'exec') {
			if(length(sql) == 0) {
				cat('No SQL to execute\n')
			} else if(missing(conn)) {
				cat('No database connection available\n')
			} else {
				cat('Executing SQL...\n')
				df <- sqlexec(conn, sql=gsub("\n", " ", sql), ...)
				cat(paste(nrow(df), ' rows of ', ncol(df), ' variables returned\n', sep=''))
			}
		} else if(line == 'print') {
			cat(sql)
			cat('\n')
		} else if(line == 'sql') {
			cat("Enter SQL statement ending with semicolon:\n")
			sql <- character()
			line <- readLines(n=1)
			while(substr(line, nchar(line), nchar(line)) != ';') {
				sql <- paste(sql, line, sep='\n')	
				line <- readLines(n=1)
			}
			sql <- paste(sql, substr(line, 1, nchar(line)-1), sep='\n')
		} else if(substr(line, 1, 4) == 'save') {
			if(is.null(df)) {
				cat('No data frame to save. Try exec first.')
			} else {
				dfname <- 'sql.results'
				if(nchar(line) > 6) {
					dfname <- substr(line, 6, nchar(line))
				}
				assign(dfname, df, envir=.GlobalEnv)
				cat(paste('Data frame ', dfname, ' saved to global environment\n', sep=''))
			}
		} else if(line == 'edit') {
			require(tcltk)
			OnOK <- function() {
				sql <<- tclvalue(tkget(txt,"0.0","end"))
				tkdestroy(tt)
			}
			OnCancel <- function() {
				tkdestroy(tt)
			}
			tt  <- tktoplevel()
			tkpack(tklabel(tt,text="SQL Entry"))	
			txt <- tktext(tt)
			tkmark.set(txt,"insert","0.0")
			tkinsert(txt, "end", sql)
			OK.button <- tkbutton(tt, text="OK", command=OnOK)
			Cancel.button <- tkbutton(tt, text="Cancel", command=OnCancel)
			tkpack(txt)
			tkpack(OK.button, Cancel.button)
			tkfocus(txt)
			tkbind(tt, "<Destroy>", function() { tkgrab.release(tt) })
			tkwait.window(tt)
		} else if(line == 'help') {
			cat('   Command      Description\n')
			cat('   ___________  ______________________________________________________\n')
			cat('   quit         quit interactive mode\n')
			cat('   help         display this message\n')
			cat('   sql          enter SQL statement\n')
			cat('   edit         edit SQL in a separate text window\n')
			cat('   print        print the last entered SQL statement\n')
			cat('   exec         execute that last entered SQL statement\n')
			cat('   save [name]  save the last executed query to the global environment\n')
		}
		cat("SLQ>"); line <- readLines(n=1)
	}
	
	invisible(gsub("\n", " ", sql))
}

