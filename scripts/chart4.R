# Chart 4
# Dataset Top 50 Spotify Song - 2019

# question: Does a slower tempo make a song sadder?

library(ggplot2)
library("dplyr") 

slow_is_sad <- function(df){
  ggplot(df) +
  geom_smooth(mapping = aes(x = df$Beats.Per.Minute, y = df$Valence.), color = "Red") +
  labs(
    title = "Slow song = sad?",
    x = "Beats per Minute",
    y = "Valence"
  )
}