\name{sqlexec.RMySQL}
\alias{sqlexec.RMySQL}
\title{Executes queries for RMySQL package.}
\usage{
  \method{sqlexec}{RMySQL} (connection, sql, ...)
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
  Executes queries for RMySQL package.
}

