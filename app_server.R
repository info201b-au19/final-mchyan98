# Load dataset
top2019 <- read.csv("data/top50.csv", stringsAsFactors = FALSE)

server <- function(inputs, outputs) {
  # map1 output
  outputs$popularityPlot <- renderPlotly({
    y_factor <- inputs$yaxis
    y_factor_edit <- y_factor 
    if (y_factor == "Valence") {
      y_factor_edit <- paste0(y_factor, ".")
    }
    if (y_factor == "Acousticness") {
      y_factor_edit <- paste0(y_factor, "..")
    } 
    p <- plot_ly(data = top2019,
                 type = "scatter",
                 x = ~Popularity,
                 y = ~top2019[[y_factor_edit]],
                 mode = "markers",
                 text = ~paste0("Popularity: ", Popularity, 
                                "<br />", y_factor, ": ",
                                top2019[[y_factor_edit]]),
                 hoverinfo = "text",
                 marker = list(size = 5)) %>% 
      layout(title = paste0("Popularity vs. ", y_factor),
             xaxis = list(zeroline = FALSE,
                          title = "Popularity"),
             yaxis = list(zeroline = FALSE,
                          title = y_factor))
  })
  
  # map2 output
  outputs$singerOutput <- renderPlotly({
    singerName1 <- inputs$singer1
    singerName2 <- inputs$singer2
    dataFilter1 <- dataEdit(top2019, singerName1)
    dataFilter2 <- dataEdit(top2019, singerName2)
    song1 <- songpl(dataFilter1, "song")
    song2 <- songpl(dataFilter2, "song")
    color1 <- "rgb(158,202,225)"
    color2 <- "rgb(58,200,225)"
    p1 <- plotBar(dataFilter1, singerName1, song1, color1)
    p2 <- plotBar(dataFilter2, singerName2, song2, color2)
    subplot(p1, p2, nrows = 2, margin = 0.05) %>% hide_legend()
  })
 
  # count average popularity of the singer' all songs
  outputs$singer1Average <- renderText({
    singerName <- inputs$singer1
    dataFilter <- dataEdit(top2019, singerName)
    song <- songpl(dataFilter, "song")
    avg <- sum(dataFilter[, "Popularity"])/nrow(dataFilter)
    avgInfo <- paste0("Average popularity of ", singerName, "'s ", song,
                       "is ", avg)
  })
  
  outputs$singer2Average <- renderText({
    singerName <- inputs$singer2
    dataFilter <- dataEdit(top2019, singerName)
    song <- songpl(dataFilter, "song")
    avg <- sum(dataFilter[, "Popularity"])/nrow(dataFilter)
    avgInfo <- paste0("Average popularity of ", singerName, "'s ", song,
                      "is ", avg)
  })
}

# filter out the singer's songs
dataEdit <- function(df, name1) {
  dataSet <- top2019 %>% 
    filter(Artist.Name == name1)
}

# adding 's' in the case when singer has more than one songs
songpl <- function(df, song) {
  if (nrow(df) > 1) {
    song <- "songs"
  }
}

# plot bar chart
plotBar <- function (df, name, song, col) {
  anno <- list(text = paste0(name, "'s ", song),
               xref = "paper",
               yref = "paper",
               yanchor = "bottom",
               xanchor = "center",
               align = "center",
               x = 0.5,
               y = 1,
               showarrow = FALSE)
  
  plot_ly(df) %>% 
    add_trace(x = ~Popularity,
              y = ~Track.Name,
              type = "bar",
              width = 0.2,
              orientation = "h",
              marker = list(color = col)
    ) %>% 
    layout(xaxis = list(range = c(0, 100)),
           yaxis = list(title = "Track Name"),
           autosize = F, width = 600, height = 600,
           annotations = anno)
}