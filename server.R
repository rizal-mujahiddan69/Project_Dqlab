library(shiny)

server <- function(input, output, session){
  output$tulisan <- renderText(
    paste(input$tulisan)
  )
}

shinyApp(ui, server)