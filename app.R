# Load the needed packages
library("shiny")
library("ggplot2")
library("plotly")
library("hexbin")
library("leaflet")
library("dplyr")

# Source in ui and server
source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)