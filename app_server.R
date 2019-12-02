# Load dataset
top2019 <- read.csv("data/top50.csv")
songData <- read.csv("data/song_data")

server <- function(inputs, outputs) {
  # map1 output
  outputs$popularityPlot <- renderPlotly({
    x_factor <- inputs$xaxis
    y_factor <- inputs$yaxis
    x_factor_edit <- x_factor
    y_factor_edit <- y_factor 
    if (x_factor == "Valence") {
      x_factor_edit <- paste0(x_factor, ".")
    } else if (y_factor == "Valence") {
      y_factor_edit <- paste0(y_factor, ".")
    } else if (x_factor == "Acousticness") {
      x_factor_edit <- paste0(x_factor, "..")
    } else if (y_factor == "Acousticness") {
      y_factor_edit <- paste0(y_factor, "..")
    } 
    p <- plot_ly(data = top2019,
                 type = "scatter",
                 x = ~top2019[[x_factor_edit]],
                 y = ~top2019[[y_factor_edit]],
                 mode = "markers",
                 text = ~paste0(x_factor, ": ", top2019[[x_factor_edit]], 
                                "<br />", y_factor, ": ",
                                top2019[[y_factor_edit]]),
                 hoverinfo = "text",
                 marker = list(size = 5)) %>% 
      layout(title = paste0(x_factor, " vs. ", y_factor),
             xaxis = list(zeroline = FALSE,
                          title = x_factor),
             yaxis = list(zeroline = FALSE,
                          title = y_factor))
  })
}