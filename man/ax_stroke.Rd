% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/apex-utils.R
\name{ax_stroke}
\alias{ax_stroke}
\title{Stroke properties}
\usage{
ax_stroke(
  ax,
  show = NULL,
  curve = NULL,
  lineCap = NULL,
  width = NULL,
  colors = NULL,
  dashArray = NULL,
  ...
)
}
\arguments{
\item{ax}{An \code{\link[=apexchart]{apexchart()}} \code{htmlwidget} object.}

\item{show}{Logical. To show or hide path-stroke / line}

\item{curve}{In line / area charts, whether to draw smooth lines or straight lines.
Available Options: \code{"smooth"} (connects the points in a curve fashion. Also known as spline)
and \code{"straight"} (connect the points in straight lines.).}

\item{lineCap}{For setting the starting and ending points of stroke. Available Options:
\code{"butt"} (ends the stroke with a 90-degree angle), \code{"square"}
(similar to butt except that it extends the stroke beyond the length of the path)
and \code{"round"} (ends the path-stroke with a radius that smooths out the start and end points)}

\item{width}{Sets the width of border for svg path.}

\item{colors}{Colors to fill the border for paths.}

\item{dashArray}{Creates dashes in borders of svg path. Higher number creates more space between dashes in the border.}

\item{...}{Additional parameters.}
}
\value{
An \code{\link[=apexchart]{apexchart()}} \code{htmlwidget} object.
}
\description{
Stroke properties
}
\note{
See \url{https://apexcharts.com/docs/options/stroke/}
}
\examples{
data("economics", package = "ggplot2")
apex(
  data = economics,
  mapping = aes(x = date, y = uempmed),
  type = "line"
) \%>\%
  ax_stroke(
    width = 1, 
    dashArray = 4
  )

data("economics_long", package = "ggplot2")
apex(
  data = economics_long,
  mapping = aes(x = date, y = value01, group = variable),
  type = "line"
) \%>\%
  ax_stroke(
    width = c(1, 2, 3, 4, 5), 
    dashArray = c(1, 2, 3, 4, 5)
  )
}
