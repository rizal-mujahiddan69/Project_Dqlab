library(shiny)
source("analisis.R")


# Define UI for application that draws a histogram
ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", 
              href = "bootstrap.css")
  ),
  tags$h1(textOutput("rizal"),align="center",class="thetitle"),
  navbarPage("Menu",
    tabPanel("Pendahuluan",
      tags$div( class="diving",
        tags$p("Kenalkan Nama Saya Rizal Mujahiddan. Identitas Saya adalah"),
        tags$ul( 
          tags$li("Nama   : Rizal Mujahiddan"),
          tags$li("TTD    : Depok, 6 April 2001"),
          tags$li("Status : Belum Menikah"),
        ),
        tags$p(paste("Project Kali ini membuktikan Bahwa ",
                     "Sebenarnya Pendapatan Wisata bisa mempengaruhi",
                     "GDP di Suatu masyarakat secara luas ",sep=" "))
      ),
      tags$div(
        tags$p(style = "border : 5px solid red;" ,
          "Dengan Penulis Hipotesis Bahwa pendapatan Wisata korelasi dengan GDP"
        )
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
