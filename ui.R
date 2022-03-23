library(shiny)
source("analisis.R")


# Define UI for application that draws a histogram
ui <- fluidPage(
  tags$head(
    tags$link(rel="stylesheet",
    href = "https://fonts.googleapis.com/css2?family=Material+Icons"),
    tags$link(rel = "stylesheet", type = "text/css", 
              href = "css/bootstrap.css"),
    tags$script(type="text/javascript",src="js/script.js")
  ),
  tags$h1(textOutput("rizal"),align="center",class="thetitle"),
  navbarPage("Menu",
    tabPanel("Pendahuluan",
      tags$div(
        tags$div(class="row",
          tags$div(class="col-sm-3",
            tags$img(src="image/Rizalku.jpg", width="90%" ,class="rounded")
          ),
          tags$div(class="card col-sm-9 bg-primary text-center",
                   style="padding :30px ;border-radius: 10% !important;",
            tags$div(class="h1",
            "Rizal Mujahiddan Identity"
            ),
            tags$button(onclick="show()",type="button",
                        class="btn btn-success","Reveal"),
            tags$div(id="shower",style="display:none;",
              tags$ul(style="list-style-type:none;",
                tags$li(tags$span("Instagram")),
                tags$li("rizal.mujahiddan@gmail.com"),
                tags$li("Rizal Mujahiddan")
              )
            )
          )
        )
      ),
      tags$div(
        tags$p(style = "border : 5px solid red; "
          ,"Dengan Penulis Hipotesis Bahwa pendapatan Wisata korelasi dengan GDP"
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
