# chart 3
# Dataset Top 50 Spotify Song - 2019

# question: which genre of music do people like best?
# 

library(ggplot2)
library("dplyr") 

popularity_off_bpm <- function(df){
  ggplot(df) +
  geom_smooth(mapping = aes(x = df$Beats.Per.Minute, y = df$Popularity))+
  geom_point(mapping = aes(x = df$Beats.Per.Minute, y = df$Popularity), color = "Red") +
  
  labs(
    title = "Popularity in relation to Beats per Minute",
    x = "Beats per Minute",
    y = "Popularity"
  )
}