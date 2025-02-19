# app_ui

# Load dataset
top2019 <- read.csv("data/top50.csv",
                    fileEncoding="latin1",	
                    encoding="UTF-8",
                    stringsAsFactors = FALSE)

introduction <- tabPanel("Project Overview",
                         tags$div(class = "overview", checked = NA,
                                  tags$h1("Project Overview"),
                                  tags$h3("Top 50 Spotify Data"),
                                  tags$img(src = "spotifytop50.jpg", width = "300px"),
                                  tags$br(),
                                  tags$br(),
                                  tags$p("For our project, we used the top50.csv data set
                                          which shows the Top 50 most listened to songs on Spotify.
                                          The data takes into account 13 different variables
                                          about the songs (such as genre, year, beats per minute, etc.),
                                          and the variables were all extracted from Spotify's
                                          Organize Your Music function. This data was last
                                          updated on August 8, 2019, and the #1 song as of that date
                                          was Senorita by Shawn Mendes. Music is a big part
                                          of people's daily lives and we chose to analyze this dataset
                                          because we are interested in how it changes people's lives, and
                                          what specific factors affect the popularity of the songs.
                                          It was intriguing to learn about why certain songs are more
                                          popular than others and how certain platforms create playlists
                                          based on the data they have."),
                                  tags$br(),
                                  tags$h3("Some major questions we are seeking to answer are:"),
                                  tags$li("What factors affect the popularity of a song?"),
                                  tags$li("Who is the most popular artist in the Top 50 list?"),
                                  tags$li("What determines the mood of a song?"),
                                  tags$br(),
                                  tags$h3("The data that we are using to answer these questions are:"),
                                  tags$li("We are taking in data of different factors (danceability,
                                          valence, energy, liveness, and acousticness) and letting the user
                                          choose a factor to see its affect on the popularity of songs in
                                          the Top 50 data."),
                                  tags$li("We are inputting data of the singers in the Top 50 list
                                          and letting the user choose two singers to compare
                                          and a bar chart will indicate which singer is more popular."),
                                  tags$li("We are taking in data of factors (energy, loudness,
                                          and beats per minute) to show how the factors make a song 
                                          happy or sad."),
                                  tags$br(),
                                  tags$img(src = "spotifyalbum.png", width = "700px"),
                                  tags$br(),
                                  tags$br()
                                  )
)

# map1: explore what factors affect the popularity of a song
# factors include: dancibility, valence, energy, liveness,
# Acousticness
map1 <- tabPanel("Popularity of a Song",
                 sidebarLayout(
                   sidebarPanel(
                     tags$div(class = "map1", checked = NA,
                              tags$p("This chart intends to find out how
                                     different factors will affect the 
                                     popularity of a song. The users can
                                     select factors from danceability, 
                                     valence, energy, liveness, 
                                     acousticness."),
                              tags$br(),
                              tags$li("Popularity: The higher the value the 
                                      more popular the song is."),
                              tags$li("Danceability: The higher the value, the
                                      easier it is to dance to this song."),
                              tags$li("Valence: The higher the value, 
                                      the more positive mood for the song."),
                              tags$li("Energy: The higher the value, the 
                                      more energtic. song."),
                              tags$li("Liveness: The higher the value, the more 
                                      likely the song is a live recording."),
                              tags$li("Acousticness: The higher the value the 
                                      more acoustic the song is."),
                              tags$hr()),
                     
                     selectInput("yaxis",
                                 "Please select a factor: ",
                                 choices = c("Danceability", "Valence",
                                             "Energy","Liveness", 
                                             "Acousticness"))
                   ),
                   mainPanel(
                     plotlyOutput(outputId = "popularityPlot")
                   )
                 )
)

# extract singers' names
nameSinger <- unique(as.character(top2019[, "Artist.Name"]))
removeRosal <- "ROSAL\315A" 
nameSinger <- nameSinger[!(nameSinger %in% removeRosal)]

map2 <- tabPanel("Singer Battle",
                 sidebarLayout(
                   sidebarPanel(
                     tags$div(class = "commet", checked = NA,
                              tags$p("These two bar charts show the 
                                     popularity of given singer's songs. The
                                     users can choose two singers and it will
                                     calculate the average popularity of
                                     singer's songs and tell the winner."),
                              tags$p(
                              tags$small("* The singers
                                     are from 2019 Spotify's Top 50 popular
                                     songs.")),
                              tags$hr()),
                     selectInput("singer1",
                                 "Please select singer one: ",
                                 choices = c(nameSinger)),
                     selectInput("singer2",
                                 "Please select singer two: ",
                                 choices = c(nameSinger))
                   ),
                   mainPanel(
                     plotlyOutput(outputId = "singerOutput"),
                     tags$br(style = "line-height:200px;"),
                     textOutput(outputId = "singer1Average"),
                     textOutput(outputId = "singer2Average"),
                     textOutput(outputId = "singerWinner")
                   )
                 ))


map3 <- tabPanel("What Makes Songs a Mood",
                 sidebarLayout(
                   sidebarPanel(
                     tags$div(class = "commet", checked = NA,
                              tags$p("Valence indicates the mood of a song,
                                     the higher the valence value, the more
                                     positive mood for the song. In this
                                     section, the users can find out what
                                     determines the mood of a song. Also,
                                     the users can choose a maximum value of
                                     the chosen category."),
                              tags$br(),
                              tags$p("The three categories are: "),
                              tags$li("Energy: The higher the value, the 
                                      more energtic. song."),
                              tags$li("Loudness: The higher the value, 
                                      the louder the song."),
                              tags$li("Beat per minute: The tempo of the 
                                      song."),
                              tags$hr()),
                     radioButtons("category", "Choose a category to see what 
                                  affects Valence of a song",
                                  c("Energy",
                                    "Loudness",
                                    "Beats Per Minute")),
                     sliderInput(
                       inputId = "max", 
                       label = "Please set max value of category", 
                       min = 0,
                       max = 100,
                       value = c(50)
                     )
                   ),

                   mainPanel(
                     plotlyOutput(outputId = "filterplot")
                   )
            )
)


takeaways <- tabPanel("Takeaways",
                      tags$div(class = "takeaway", checked = NA,
                              tags$h1("Main Takeaways"),
                              tags$br(),
                              tags$li("There is no formula to getting a popular song.
                                      Songs that were popular varied a lot in the amount 
                                      of energy, danceability, valence, liveness, 
                                      and acousticness that each had."),
                              tags$li("From our singer battle, we concluded that Bad Bunny
                                      was the most popular artist of 2019 on average. However, she
                                      did not have the single most popular song. The single most
                                      popular song was bad guy by Billie Eilish."),
                              tags$li("There is also a trend with the valence of a song and
                                      it's energy, meaning that songs that were typically
                                      sadder tend to have less energy associated with them."),
                              tags$img(src = "energytrend.png", width = "600px"))
)

ui <- navbarPage(
  "Spotify 2019 Top 50 Data",
  introduction,
  map1,
  map2,
  map3,
  takeaways,
  theme = "styles.css"
)
