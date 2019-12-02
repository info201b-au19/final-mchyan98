# app_ui

introduction <- tabPanel("Project title",
                         h1("Introduction")
  # what question are we answering?
  # add some images
)

# map1: explore the relationship between different factors of 
# a song. For example, is there any relationship between danceability
# and energe of the songs.
map1 <- tabPanel("Popularity of a song",
                 sidebarLayout(
                   sidebarPanel(
                     selectInput("xaxis",
                                 "Please select the factor of x-axis",
                                 choices = c("Danceability", "Valence",
                                             "Energy", "Popularity",
                                             "Liveness", "Acousticness")),
                     selectInput("yaxis",
                                 "Please select the factor of y-axis",
                                 choices = c("Danceability", "Valence",
                                             "Energy", "Popularity",
                                             "Liveness", "Acousticness"))
                   ),
                   mainPanel(
                     plotlyOutput(outputId = "popularityPlot")
                   )
                 )
)

map2 <- tabPanel("Singer Battle",
                 sidebarLayout(
                   sidebarPanel(
                     textInput(inputId = "singer1",
                               label = "Please enter singer one:"),
                     textInput(inputId = "singer2",
                               label = "Please enter singer two:")
                   ),
                   mainPanel(
                     plotlyOutput(outputId = "singerBattle")
                   )
                 ))

ui <- navbarPage(
  "App titile",
  introduction,
  map1,
  map2
  # map3
)