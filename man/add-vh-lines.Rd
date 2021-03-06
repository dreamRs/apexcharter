% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/annotations.R
\name{add-vh-lines}
\alias{add-vh-lines}
\alias{add_hline}
\alias{add_vline}
\title{Add horizontal or vertical line}
\usage{
add_hline(ax, value, color = "#000", dash = 0, label = NULL, ...)

add_vline(ax, value, color = "#000", dash = 0, label = NULL, ...)
}
\arguments{
\item{ax}{An \code{apexcharts} \code{htmlwidget} object.}

\item{value}{Vector of position for the line(s).}

\item{color}{Color(s) of the line(s).}

\item{dash}{Creates dashes in borders of SVG path.
A higher number creates more space between dashes in the border.
Use \code{0} for plain line.}

\item{label}{Add a label to the shade, use a \code{character}
or see \code{\link{label}} for more controls.}

\item{...}{Additional arguments, see
\url{https://apexcharts.com/docs/options/annotations/} for possible options.}
}
\value{
An \code{apexcharts} \code{htmlwidget} object.
}
\description{
Add horizontal or vertical line
}
\examples{

library(apexcharter)

# On a column chart
apex(
  data = table(unhcr_popstats_2017$continent_residence),
  aes(Var1, Freq),
  "column"
) \%>\% 
  add_hline(value = 2100)


# On a scatter chart
apex(
  data = iris,
  aes(Sepal.Length, Sepal.Width),
  "scatter"
) \%>\% 
  add_hline(value = mean(iris$Sepal.Width)) \%>\% 
  add_vline(value = mean(iris$Sepal.Length))

# With labels
apex(
  data = iris,
  aes(Sepal.Length, Sepal.Width),
  "scatter"
) \%>\% 
  add_hline(
    value = mean(iris$Sepal.Width),
    label = "Mean of Sepal.Width"
  ) \%>\% 
  add_vline(
    value = mean(iris$Sepal.Length),
    label = "Mean of Sepal.Length"
  )
}
