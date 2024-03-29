% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/apex-utils.R
\name{ax_theme}
\alias{ax_theme}
\title{Theme for charts}
\usage{
ax_theme(ax, mode = c("light", "dark"), palette = NULL, monochrome = NULL, ...)
}
\arguments{
\item{ax}{An \code{\link[=apexchart]{apexchart()}} \code{htmlwidget} object.}

\item{mode}{use light or dark theme.}

\item{palette}{Character. Available palettes: \code{"palette1"} to \code{"palette10"}.}

\item{monochrome}{A list of parameters.}

\item{...}{Additional parameters.}
}
\value{
An \code{\link[=apexchart]{apexchart()}} \code{htmlwidget} object.
}
\description{
Theme for charts
}
\note{
See \url{https://apexcharts.com/docs/options/theme/}
}
\examples{
data("mpg", package = "ggplot2")
data("diamonds", package = "ggplot2")

# Dark mode
apex(
  data = mpg,
  mapping = aes(x = manufacturer)
) \%>\% 
  ax_theme(mode = "dark")

# Use predefined palette (1 to 10)
apex(
  data = diamonds,
  mapping = aes(x = color, fill = cut)
) \%>\% 
  ax_theme(palette = "palette2")

# monochrome palette
apex(
  data = diamonds,
  mapping = aes(x = color, fill = cut)
) \%>\% 
  ax_theme(monochrome = list(enabled = TRUE, color = "#0B6121"))
}
