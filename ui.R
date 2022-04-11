library(shiny)
source("analisis.R")

# Define UI for application that draws a histogram
ui <- fluidPage(
  tags$head(
    tags$link(rel="stylesheet",
    href = "https://fonts.googleapis.com/icon?family=Material+Icons"),
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
                tags$li(tags$span("Instagram"),tags$span("Rizal Mujahiddan")),
                tags$li(tags$span("e-mail"),tags$span("rizal.mujahiddan@gmail.com")) ,
                tags$li(tags$span("Linkedin"),tags$span("Rizal Mujahiddan"))
              )
            ),
            tags$button(onclick="location.href='https://github.com/rizal-mujahiddan69/Project_Dqlab';",type="button",
                        class="btn btn-warning","My Github"),
            
          )
        )
      ),
      tags$div(class="row",
        tags$div(class="card bg-info shadowing",
          "Disini, Penulis akan mencari korelasi antara banyaknya wisatawan 
          dengan Pendapatan nasional. Untuk data Sendiri, penulis didapatkan dari
          data world bank. Disini variable independent adalah International 
          tourism number of arrivals , dan variable dependent adalah
          GDP per capita current US .Berikut ini adalah Metadata. ",
          tags$a(href="https://infopublik.id/kategori/nasional-ekonomi-bisnis/599397/wisatawan-nusantara-jadi-andalan-pemulihan-sektor-pariwisata-nasional",
                 "Ini adalah Berita mengenai jurnalisme")
          ),

        ),
        tags$div(dataTableOutput("table_metadata"))
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
      ),
      sidebarLayout(       
        sidebarPanel(
          selectInput("kolom2", "Indicator Name",
                      names(data_sheet)[-c(1)])
        ),
        mainPanel("",
          plotOutput("PlotLine2")
          
        )
      )
    ),
    # tabPanel("Map Plot",
    #   sidebarLayout(
    #     sidebarPanel(
    #       selectInput("kolom_tahun","Rizal Ganteng",
    #                   names(data_world_gdp)[-c(1)])
    #     )
    #   ),
    #   mainPanel("GDP",
    #     leafletOutput("MapPlot")
    #   )
    # ),
    
    
    #  tabPanel("Pie Plot",
    #    sidebarLayout(
    #      sidebarPanel(
    #        selectInput("kolom_tahun","Rizal Ganteng",
    #                    names(data_world_gdp)[-c(1)])
    #      )
    #    ),
    #    mainPanel("GDP",
    #      leafletOutput("PiePlot")
    #    )
    # ),
    tabPanel("Main Plot",
      mainPanel(tags$h1("Tugas"),
        plotOutput("linearreg"),
        plotOutput("crccf"),
        textOutput("lm_diag"),
        textOutput("tulisan_auto"),
        img(src="image/Hasil_Koyck.png"),
        textOutput("kesimpulan")
      )
    ),
  ),
)
