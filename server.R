library(shiny)
library(mice)
library(readxl)
library(tidyverse)
library(visdat)

server <- function(input, output,session) {
  # rm(list=ls())
  output$rizal <- shiny::renderText({
    "Rizal"
  })
  output$Plotting <- renderPlot({
    x <- rnorm(100,sd=3)
    y <- rnorm(100,sd=3)
    plot(x,y)
  })
  session$allowReconnect(TRUE)
}