library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  mainPanel(
    shiny::plotOutput("Plotting")
  )
)