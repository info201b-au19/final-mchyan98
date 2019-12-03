# app_ui

introduction <- tabPanel("Project Overview",
                         h1("Project Overview"),
                         h2("Top 50 Spotify Data"),
                         h3("...")
  # what question are we answering?
  # add some images
)

# map1: explore what factors affect the popularity of a song
# factors include: dancibility, valence, energy, liveness,
# Acousticness
map1 <- tabPanel("Popularity of a Song",
                 sidebarLayout(
                   sidebarPanel(
                     tags$div(class = "commet", checked = NA,
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

map2 <- tabPanel("Singer Battle",
                 sidebarLayout(
                   sidebarPanel(
                     selectInput("singer1",
                                 "Please select singer one: ",
                                 choices = c(nameSinger)),
                     selectInput("singer2",
                                 "Please select singer two: ",
                                 choices = c(nameSinger))
                   ),
                   mainPanel(
                     plotlyOutput(outputId = "singerOutput"),
                     tags$hr(),
                     textOutput(outputId = "singer1Average"),
                     textOutput(outputId = "singer2Average")
                   )
                 ))

takeaways <- tabPanel("Takeaways",
                         h1("3 Major Takeaways"),
                         h3("...")
)

ui <- navbarPage(
  "App Title",
  introduction,
  map1,
  map2,
  # map3
  takeaways
)