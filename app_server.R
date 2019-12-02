server <- function(inputs, outputs) {
  # map1 output
  outputs$popularityPlot <- renderPlotly({
    factors <- inputs$Factor
    if(factors == "Valence") {
      factor_edit <- paste0(factors, ".")
    } else {
      factor_edit <- factors
    }
    p <- plot_ly(data = top50,
                 type = "scatter",
                 x = ~Popularity,
                 y = ~top50[[factor_edit]],
                 mode = "markers",
                 text = ~paste0("Popularity: ", Popularity, 
                                "<br />", factors, ": ",
                                factor_edit),
                 hoverinfo = "text",
                 marker = list(size = 5)) %>% 
      layout(title = paste0("Popularity vs.", factors),
             xaxis = list(zeroline = FALSE,
                          title = "Popularity"),
             yaxis = list(zeroline = FALSE,
                          title = factors))
  })
}