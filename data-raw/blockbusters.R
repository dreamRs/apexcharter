## code to prepare `blockbusters` dataset goes here

# https://www.kaggle.com/datasets/narmelan/top-ten-blockbusters-20191977

# Download ----
curl::curl_download(
  url = "https://www.kaggle.com/api/v1/datasets/download/narmelan/top-ten-blockbusters-20191977",
  destfile = "data-raw/top-ten-blockbusters-20191977.zip",
  mode = "wb"
)
zip::unzip(zipfile = "data-raw/top-ten-blockbusters-20191977.zip", exdir  = "data-raw/")

# parse ----
library(data.table)
blockbusters <- fread("data-raw/Blockbusters_2019-1977.csv")
blockbusters[, worldwide_gross := as.numeric(gsub(",", "", worldwide_gross))]
blockbusters <- blockbusters[
  , list(worldwide_gross = round(sum(worldwide_gross) / 1e6, 1)),
  keyby = list(year = release_year, genre = genre_1)
]


# example ----
apex(
  # data = blockbusters[!genre %in% c("Mystery", "Horror", "Musical", "Sci-Fi", "Biography", "Crime", "Family")],
  data = blockbusters,
  mapping = aes(x = year, y = worldwide_gross, fill = genre),
  type = "streamgraph"
) |>
  ax_colors(scales::brewer_pal("qual", palette = "Set3")(uniqueN(blockbusters$genre)))

apex(
  data = blockbusters[genre %in% c("Action", "Adventure", "Comedy", "Drama", "Animation")],
  mapping = aes(x = year, y = worldwide_gross, fill = genre),
  type = "streamgraph"
) |>
  ax_colors(scales::brewer_pal("qual", palette = "Set1")(5))

apex(
  data = blockbusters[genre %in% c("Action", "Adventure", "Comedy", "Drama", "Animation")],
  mapping = aes(x = as.Date(paste0(year, "-01-01")), y = worldwide_gross, fill = genre),
  type = "streamgraph"
) |>
  ax_xaxis(type = "datetime") |>
  ax_colors(scales::brewer_pal("qual", palette = "Set1")(5))


# use data ----

setDF(blockbusters)
usethis::use_data(blockbusters, overwrite = TRUE)

