library(dplyr)
library(knitr)

# Aggregated Table Showing Artists w/ # of Top 50 Songs

aggregate_summary <- function(df)
{
  top_songs_by_artists <- df %>% 
    group_by(Artist.Name) %>% 
    tally(sort = TRUE)

  top_table <- kable(top_songs_by_artists, col.names = c("Artists", "Top Songs"),
        caption = "Based on the table we can see only 10 artists had more than 1 song in the top 50 chart.")
  return(top_table)
}


