source("source_data.R")
library(shiny)

server <- function(input, output,session) {
  # rm(list=ls())
  output$rizal <- renderText({
    "Rizal Mujahiddan Project"
  })
  
  output$menu <- renderText({
    "Menu aku"
  })
  
  output$PlotLine <- renderPlot({
    plotku <- ggplot(data_sheet,aes(x=year,y=get(input$kolom))) + 
      geom_line(size=1) + 
      ggtitle(input$kolom) + 
      ylab(input$kolom) + 
      theme(plot.title = element_text(size=20,hjust = 0.5,
                                      margin = margin(t = 0, r = 0, b = 25, l = 0)),
            axis.text  = element_text(size=12),
            axis.title = element_text(size = 15),
            axis.text.y  = element_text(margin = margin(t = 0, r = 0, 
                                                        b = 0, l = 20))
            )
    plotku
    }) %>% bindCache(input$kolom)
  
  output$PlotLine2 <- renderPlot({
    ggplot(data_sheet,aes(x=year,y=get(input$kolom2))) + 
      geom_line(size=1) + 
      ggtitle(input$kolom2) + 
      ylab(input$kolom2) + 
      theme(plot.title = element_text(size=20,hjust = 0.5,
                                      margin = margin(t = 0, r = 0, b = 25, l = 0)),
            axis.text  = element_text(size=12),
            axis.title = element_text(size = 15),
            axis.text.y  = element_text(margin = margin(t = 0, r = 0, 
                                                        b = 0, l = 20))
      )
  }) %>% bindCache(input$kolom2)
  
  output$crccf <- renderPlot({
    ccf(x_hitung,y_hitung)
  })
  
  output$table_metadata <- renderDataTable({
    data_metadata()
  })
  
  output$linearreg <- renderPlot({
    ggplot(data_sheet,aes(x=International.tourism.number.of.arrivals,
                          y=GDP.per.capita.current.US.))+
              geom_point() +
              geom_smooth(method = "lm")
  })
  
  output$lm_diag <- renderText({
    dw_dia$alternative
  })
  
  output$tulisan_auto <- renderText({
    "Disini membuktikan bahwa mereka memliki autoregressive , 
    berarti harus analisis regresi dan juga harus menyelesaikan dengan memperhatikan
    lag . Dibawah ini adalah hasil dari Koyck , dengan asumsi"
  })
  
  output$kesimpulan <- renderText({
    "Kesimpulannya bahwa dengan mempertimbangkan waktu juga, bahwa sebenarnya 
    keterhubungan jumlah wisatawan dengan GDP percapita berhubungan jika kita
    lihat dari R squared nya."
  })
  
  
  session$allowReconnect(TRUE)
}