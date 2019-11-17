# chart 1
# Dataset Top 50 Spotify Song - 2019

# question: which genre of music do people like best?
# I used pie chart here because it can show proportional representaions

library(ggplot2)
library("dplyr") 
library(plotly)

genre_counts1 <- function(df) {
  df %>% 
    group_by(Genre) %>% 
    summarize(val = n())
}

genre_counts <- function(df) {
  df %>% 
    select(Genre) %>% 
    mutate(count = 1)
}

most_popular_genre <- function(df) {
  plot_ly(df, labels = ~Genre, type = 'pie',
          hoverinfo = "text",
          text = ~paste(Genre)) %>% 
    layout(title = "Top 50 Spotify Songs in 2019 by Genre",
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
}