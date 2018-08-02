


# Parsing options ---------------------------------------------------------

cx <- V8::v8()
cx$source(file = "inst/htmlwidgets/lib/apexcharts-1.0.4/Options.js")
ApexOpts <- cx$get("Options")

names(ApexOpts)
str(ApexOpts$chart, max.level = 1)
str(ApexOpts$chart$animations, max.level = 1)



# Utils -------------------------------------------------------------------

make_fun <- function(opts, name, file = "") {
  args <- names(opts[[name]])
  if (is.null(args)) {
    args <- "..."
  } else {
    args <- sprintf("%s = NULL", args)
    args <- paste(args, collapse = ",\n")
    args <- paste0(args, ", ...")
  }
  body <- paste(
    "\nparams <- c(as.list(environment()), list(...))[-1]",
    paste0(".ax_opt2(ax, \"", name, "\", l = dropNulls(params))\n"), 
    sep = "\n"
  )
  res <- paste0("ax_", name, " <- function(ax, ", args, ") {", body, "}\n\n\n")
  cat(res, file = file, append = TRUE)
  return(invisible(res))
}

make_opts <- function(opts, name, file = "") {
  args <- names(opts[[name]])
  if (is.null(args)) {
    args <- "..."
    body <- "list(...)"
  } else {
    body <- sprintf("%s = %s", args, args)
    body <- paste(body, collapse = ",\n")
    body <- paste0("c(list(", body, "), list(...))")
    args <- sprintf("%s = NULL", args)
    args <- paste(args, collapse = ",\n")
    args <- paste0(args, ", ...")
  }
  body <- paste0("dropNulls(", body, ")")
  res <- paste0(name, "Opts", " <- function(", args, ") {", body, "}\n\n\n")
  cat(res, file = file, append = TRUE)
  return(invisible(res))
}




# chart -------------------------------------------------------------------

make_fun(ApexOpts, "chart")



# plotOptions -------------------------------------------------------------

make_fun(ApexOpts, "plotOptions")




# ALL ---------------------------------------------------------------------

lapply(
  X = names(ApexOpts),
  FUN = make_fun, opts = ApexOpts, file = "R/apex-utils.R"
)






# Options -----------------------------------------------------------------

# scroller
str(ApexOpts$chart$scroller)

make_opts(ApexOpts$chart, "scroller")

# plotOptions -- bar
make_opts(ApexOpts$plotOptions, "bar")




### write funs

# chart
str(ApexOpts$chart, max.level = 1)
make_opts(ApexOpts$chart, "scroller", file = "R/apex-options.R")
make_opts(ApexOpts$chart, "events", file = "R/apex-options.R")
make_opts(ApexOpts$chart, "selection", file = "R/apex-options.R")


# plotOptions
str(ApexOpts$plotOptions, max.level = 1)
make_opts(ApexOpts$plotOptions, "bar", file = "R/apex-options.R")
make_opts(ApexOpts$plotOptions, "heatmap", file = "R/apex-options.R")
make_opts(ApexOpts$plotOptions, "radialBar", file = "R/apex-options.R")
make_opts(ApexOpts$plotOptions, "pie", file = "R/apex-options.R")









