% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/find_undernutrition.R
\name{find_child_underweight}
\alias{find_child_underweight}
\title{Find children who are underweight from an anthropometric dataset}
\usage{
find_child_underweight(df, zscore = "waz", flag = NULL, add = TRUE)
}
\arguments{
\item{df}{A data.frame containing anthropometric z-score indices for
\verb{weight-for-age}}

\item{zscore}{A character value for variable name for
\verb{weight-for-age z-score} in \code{df}. Default is \code{waz}}

\item{flag}{A character value for variable name of coded flags applied to
\verb{weight-for-age z-score} values in \code{df}. Default is NULL indicating
that flags have already been applied and flagged values have been censored.}

\item{add}{Logical. Should recode values for underweight be added to
\code{df}? Default is TRUE}
}
\value{
if \code{add} TRUE, returns \code{df} with recode values indicating underweight
cases.
}
\description{
Find children who are underweight from an anthropometric dataset
}
\examples{

find_child_underweight(df = zscorer::anthro1,
                       zscore = "waz",
                       flag = NULL,
                       add = TRUE)

}
