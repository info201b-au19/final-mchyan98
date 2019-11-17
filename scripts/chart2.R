# chart 2
# Dataset Top 50 Spotify Song - 2019

# questions: Does the popularity of a song related to
# its dancibility, length, valence, and energy


popularity_valence <- function(df) {
  ggplot(df, aes(x=Popularity, y=Valence.)) + 
    geom_point() + 
    geom_smooth(method=lm, se=FALSE)
}

popularity_energy <- function(df) {
  ggplot(df, aes(x=Popularity, y=Energy)) + 
    geom_point() + 
    geom_smooth(method=lm, se=FALSE)
}

popularity_length <- function(df) {
  ggplot(df, aes(x=Popularity, y=Length.)) + 
    geom_point() + 
    geom_smooth(method=lm, se=FALSE)
}

popularity_danceability <- function(df) {
  ggplot(df, aes(x=Popularity, y=Danceability)) + 
    geom_point() + 
    geom_smooth(method=lm, se=FALSE)
}

four_plots <- function(df) {
  figure <- ggarrange(popularity_valence(df), popularity_valence(df), 
                 popularity_length(df), popularity_danceability(df),
                 ncol = 2, nrow = 2)
  annotate_figure(figure, 
                  top = text_grob("Relation between popularity and valence, 
                                  energy, length, and dancebility", 
                                  face = "bold", size = 14))
}