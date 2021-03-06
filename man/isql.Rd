\name{isql}
\alias{isql}
\title{Interactive SQL session.}
\usage{
  isql(conn, sql = character(), ...)
}
\arguments{
  \item{conn}{a database connection.}

  \item{sql}{initial SQL statement.}

  \item{...}{other parameters passed to
  \code{\link{sqlexec}}.}
}
\value{
  returns the last entered SQL statement.
}
\description{
  This function will start an interactive SQL session. The
  user can enter SQL statements and execute them against
  the given database connection. This was initially
  developed as a teaching tool for learning SQL.
}

