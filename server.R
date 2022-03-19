library(shiny)
source("analisis.R")

server <- function(input, output,session) {
  # rm(list=ls())
  output$rizal <- shiny::renderText({
    "Rizal Mujahiddan Project"
  })
  
  output$menu <- shiny::renderText({
    "Menu aku"
  })
  
  output$PlotLine <- renderPlot({
    kol_pen <- input$kolom
    ggplot(data_sheet,aes(x=year,y=get(kol_pen))) + 
      geom_line(size=1) + 
      ggtitle(kol_pen) + 
      ylab(kol_pen) + 
      theme(plot.title = element_text(size=20,hjust = 0.5,
                                      margin = margin(t = 0, r = 0, b = 25, l = 0)),
            axis.text  = element_text(size=12),
            axis.title = element_text(size = 15),
            axis.text.y  = element_text(margin = margin(t = 0, r = 0, 
                                                        b = 0, l = 20))
            )
  })
  
  output$Forecast <- renderPlot({
    plot(rnorm(100),rchisq(100,3))
  })
  
  session$allowReconnect(TRUE)
}