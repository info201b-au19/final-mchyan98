# Summary INFO
# Returns a list containing
# Number of Songs
# Types of Genres
# All Artists
# Lowest Popularity Needed
# Average Song Length (Seconds)

get_summary_info <- function(df)  {
  info <- list()
  info$num_of_songs <- nrow(df)
  info$genres <- df %>%
    pull(Genre)
  info$genres <- info$genres[!duplicated(info$genres)]
  info$artists <- df %>%
    pull(Artist.Name)
  info$artists <- info$artists[!duplicated(info$artists)]
  info$min_popularity <- df %>%
    filter(Popularity == min(Popularity)) %>%
    pull(Popularity)
  info$average_length <- df %>%
    summarise(avg = mean(Length., na.rm = TRUE)) %>%
    pull(avg)
  info
}