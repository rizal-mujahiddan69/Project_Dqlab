library(shiny)

ui <- fluidPage(
  titlePanel(h1("Rizal Mujahiddan Project",align="center")),
  navbarPage("Rizal",
             tabPanel("Pendahuluan",
                      mainPanel(
                        textInput("tulisan","Nama Saya"),
                        textOutput("tulisan")
                      )
             )
  )
)