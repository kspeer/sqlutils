\name{execQuery}
\alias{execQuery}
\title{Executes the specified query and returns a data frame. This function currently
supports RODBC, RSQLite, and RMySQL. For other databases, use getQuery() and
execute the SQL statement using the appropriate database connection.}
\usage{
  execQuery(query = NULL, connection = NULL,
    maxLevels = 20, ...)
}
\arguments{
  \item{query}{the query to execute.}

  \item{connection}{the database connection.}

  \item{maxLevels}{the maximum number of levels a factor
  can have before being converted to a character.}

  \item{...}{other parameters passed to
  \code{\link{getSQL}} and \code{\link{sqlexec}}.}
}
\description{
  Executes the specified query and returns a data frame.
  This function currently supports RODBC, RSQLite, and
  RMySQL. For other databases, use getQuery() and execute
  the SQL statement using the appropriate database
  connection.
}
\seealso{
  sqlexec, cacheQuery
}

