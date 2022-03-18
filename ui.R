library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Plotting")
    )
  )