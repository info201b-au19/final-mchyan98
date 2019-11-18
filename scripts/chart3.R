# chart 3
# Dataset Top 50 Spotify Song - 2019

# question: Does Beats per minute contribute to popularity?

library(ggplot2)
library("dplyr") 

BPM_summ <- function(df){
  ggplot(df,
      aes(x=factor(0),Beats.Per.Minute)) + 
      geom_boxplot()+
      theme(axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank())
}