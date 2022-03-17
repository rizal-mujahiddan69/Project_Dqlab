library(shiny)
library(caret)
library(ggplot2)

server <- function(input, output, session){
  output$tulisan <- renderText(
    paste(input$tulisan)
  )
}

shinyApp(ui, server)