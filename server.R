library(shiny)
library(mice)
library(readxl)
library(tidyverse)
library(visdat)

data_src <- read_excel("Data_World.xls",sheet = "Data",skip = 2)
names(data_src)[1:4] <- make.names(names(data_src)[1:4])
names(data_src)

data_src <- data_src %>% 
  select(-c(Country.Name,Country.Code)) %>% 
  pivot_longer(names(data_src)[-c(1:4)],names_to = "year")

data_src$year <-  as.numeric(data_src$year)



server <- function(input, output,session) {
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
  output$Plotting <- renderPlot({
    plot(data_src$year,data_src$value)
  })
  session$allowReconnect(TRUE)
}