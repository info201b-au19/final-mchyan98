# Load dataset
top2019 <- read.csv("data/top50.csv",
                    fileEncoding="latin1",
                    encoding="UTF-8",
                    stringsAsFactors = FALSE)

server <- function(input, output) {
  # map1 output
  output$popularityPlot <- renderPlotly({
    y_factor <- input$yaxis
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
                 marker = list(size = 5, color = "rgb(20,172,100)")) %>% 
      layout(title = paste0("Popularity vs. ", y_factor),
             xaxis = list(zeroline = FALSE,
                          title = "Popularity"),
             yaxis = list(zeroline = FALSE,
                          title = y_factor))
  })
  
  # map2 output
  output$singerOutput <- renderPlotly({
    singerName1 <- input$singer1
    singerName2 <- input$singer2
    dataFilter1 <- dataEdit(top2019, singerName1)
    dataFilter2 <- dataEdit(top2019, singerName2)
    song1 <- songpl(dataFilter1, "song")
    song2 <- songpl(dataFilter2, "song")
    color1 <- "rgb(20,172,100)"
    color2 <- "rgb(25,27,26)"
    p1 <- plotBar(dataFilter1, singerName1, song1, color1)
    p2 <- plotBar(dataFilter2, singerName2, song2, color2)
    subplot(p1, p2, nrows = 2, margin = 0.05) %>% hide_legend()
  })

  output$singer1Average <- renderText({
    singerName1 <- input$singer1
    dataFilter1 <- dataEdit(top2019, singerName1)
    song1 <- songpl(dataFilter1, "song")
    avg1 <- average(dataFilter1) 
    avgInfo1 <- paste0("Average popularity of ", singerName1, "'s ", song1,
                       "is ", avg1, ".")
  })
  
  output$singer2Average <- renderText({
    singerName2 <- input$singer2
    dataFilter2 <- dataEdit(top2019, singerName2)
    song2 <- songpl(dataFilter2, "song")
    avg2 <- average(dataFilter2)
    avgInfo2 <- paste0("Average popularity of ", singerName2, "'s ", song2,
                       "is ", avg2, ".")
  })
  
  output$singerWinner <- renderText({
    singerName1 <- input$singer1
    singerName2 <- input$singer2
    dataFilter1 <- dataEdit(top2019, singerName1)
    dataFilter2 <- dataEdit(top2019, singerName2)
    song1 <- songpl(dataFilter1, "song")
    song2 <- songpl(dataFilter2, "song")
    avg1 <- average(dataFilter1) 
    avg2 <- average(dataFilter2)
    winner <- ""
    if (avg1 > avg2) {
      winner <- paste0(singerName1, " wins!")
    } else if (avg1 < avg2) {
      winner <- paste0(singerName2, " wins!")
    } else {
      winner <- paste("They tie.")
    }
  })


# Filters out the singer's songs
dataEdit <- function(df, name1) {
  dataSet <- top2019 %>% 
    filter(Artist.Name == name1)
}

# Adds 's' in the case when singer has more than one songs
songpl <- function(df, song) {
  if (nrow(df) > 1) {
    song <- "songs"
  }
}

# Plots bar chart
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
              marker = list(color = col),
              text = paste0("Track name: ", df[["Track.Name"]], "<br />",
                            "Popularity: ", df[["Popularity"]]),
              hoverinfo = "text"
    ) %>% 
    layout(xaxis = list(range = c(0, 100)),
           yaxis = list(title = "Track Name"),
           autosize = F, width = 600, height = 600,
           annotations = anno)
}

# Calculates average popularity of singer's song(s)
average <- function(df) {
  avg <- sum(df[, "Popularity"])/nrow(df)  
}



# map3 output
# Question: What makes a song sad or happy?

output$filterplot <- renderPlotly({
category <- input$category
  
top2019$Loudness..dB.. <- top2019$Loudness..dB.. + 6
  new1 <- top2019 %>%
    filter(Valence. <= input$max)
  
  
  if (category == "Energy") {
    new1 <- new1 %>%
      select(Valence., Energy)
    y <- new1$Energy
  } else if (category == "Loudness") {
    new1 <- new1 %>%
      select(Valence., Loudness..dB..)
    y <- new1$Loudness..dB..
  } else { # category == "BPM"
    new1 <- new1 %>%
      select(Valence., Beats.Per.Minute)
    y <- new1$Beats.Per.Minute
  }

  x <- new1$Valence.
  
  plot_ly(data = new1, x = x, y = y) %>%
    add_markers(y = y, text = new1$Track.Name, showlegend = FALSE,
                marker = list(color = "rgb(20,172,100)")) %>%
    add_lines(y = ~fitted(loess(y ~ x)),
              line = list(color = "rgb(25,27,26)"),
              name = "Line of Best Fit", showlegend = TRUE) %>%
    layout(
      title = "Valence Relationships",
      xaxis = list(title = "Valence"),
      yaxis = list(title = paste(category))
    )
  
})
}
