library(shiny)
source("analisis.R")


# Define UI for application that draws a histogram
ui <- fluidPage(
  tags$h1(textOutput("rizal"),align="center"),
  navbarPage("Menu",
    tabPanel("Pendahuluan",
      tags$div(
        tags$p("Kenalkan Nama Saya Rizal Mujahiddan. Identitas Saya adalah"),
        tags$ul( 
          tags$li("Nama   : Rizal Mujahiddan"),
          tags$li("TTD    : Depok, 6 April 2001"),
          tags$li("Status : Belum Menikah"),
        ),
        tags$p("Project Kali ini memmbuktikan Bahwa Formulasi tersebut bisa")
      )
    ),
    tabPanel("Plot Lineku",
      sidebarLayout(       
        sidebarPanel(
          selectInput("kolom", "Indicator Name",
                      names(data_sheet)[-c(1)])
        ),
        mainPanel("",
          plotOutput("PlotLine")
        )
      )
    ),
    tabPanel("Main Plot",
      mainPanel("Tugas",
        plotOutput("Forecast")      
      )
    ),
  ),
)
