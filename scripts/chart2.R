# chart 2
# Dataset Top 50 Spotify Song - 2019

# questions: Does the popularity of a song related to
# its dancibility, length, valence, and energy?
# From the resulted chart, we can see there is no obvious correlation
# between popularity and valence, energy, length, and dancebility.
# However, there is a kind of relation between popularity and dancebility:
# the songs with high popularity tend to have high dancebility. As we can
# see from the plot, the points on the rang from dancebility(60-80) are
# very densed. In regard to the relation between popularity and length of
# the songs, most of the songs with high popularity are between 150 seconds
# and 225 seconds.


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
  figure <- ggarrange(popularity_valence(df), popularity_energy(df), 
                 popularity_length(df), popularity_danceability(df),
                 ncol = 2, nrow = 2)
  annotate_figure(figure, 
                  top = text_grob("Relation between popularity and valence, 
                                  energy, length, and dancebility", 
                                  face = "bold", size = 14))
}