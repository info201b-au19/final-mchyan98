# Load the needed packages
library("shiny")
library("ggplot2")
library("plotly")
library("hexbin")
library("leaflet")
library("dplyr")

# Load dataset
top50 <- read.csv("data/top50.csv")

# Source to ui and server
source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)