# app_ui

introduction <- tabPanel("Project title",
                         h1("Introduction")
  # what question are we answering?
  # add some images
)

# map1: relationship between popularity and different factors, such as
# dancibility, valence, energy. Want to find is there any relationship
# between popularity of a song and these factors. 
map1 <- tabPanel("Popularity of a song",
                 sidebarLayout(
                   sidebarPanel(
                     selectInput("Factor",
                                 "Please select a factor",
                                 choices = c("Danceability", "Valence",
                                             "Energy"))
                   ),
                   mainPanel(
                     plotlyOutput(outputId = "popularityPlot")
                   )
                 )
)

ui <- navbarPage(
  "App titile",
  introduction,
  map1
  # map2,
  # map3
)