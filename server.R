library(shiny)
library(mice)
library(readxl)
library(tidyverse)
library(visdat)

server <- function(input, output,session) {
  # rm(list=ls())
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
  output$Plotting <- renderPlot({
    x <- rnorm(100,sd=3)
    y <- rnorm(100,sd=3)
    plot(x,y)
  })
  session$allowReconnect(TRUE)
}