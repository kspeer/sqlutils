\name{sqlexec}
\alias{sqlexec}
\title{Generic function for executing a query.}
\usage{
  sqlexec(connection, sql, ...)
}
\arguments{
  \item{connection}{the database connection.}

  \item{sql}{the query to execute.}

  \item{...}{other parameters passed to the appropriate
  \code{sqlexec} function.}
}
\value{
  a data frame.
}
\description{
  Generic function for executing a query.
}

