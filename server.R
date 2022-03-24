library(shiny)
source("analisis.R")

server <- function(input, output,session) {
  # rm(list=ls())
  output$rizal <- renderText({
    "Rizal Mujahiddan Project"
  })
  
  output$menu <- renderText({
    "Menu aku"
  })
  
  output$PlotLine <- renderPlot({
    kol_pen <- input$kolom
    pltku<- ggplot(data_sheet,aes(x=year,y=get(kol_pen))) + 
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
      pltku
    })
  
  output$PlotLine2 <- renderPlot({
    kol_pen <- input$kolom2
    plottku <-ggplot(data_sheet,aes(x=year,y=get(kol_pen))) + 
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
    plottku
  })
  
  output$crccf <- renderPlot({
    ccf(x_hitung,y_hitung)
  })
  
  output$table_metadata <- renderDataTable({
    data_metadata
  })
  
  output$linearreg <- renderPlot({
    ggplot(data_sheet,aes(x=International.tourism.number.of.arrivals,
                          y=GDP.per.capita.current.US.))+
              geom_point() +
              geom_smooth(method = "lm")
  })
  
  # output$MapPlot <- renderLeaflet({
  #   tahunku <- input$kolom_tahun
  #   palan <- colorQuantile("Greens",data_world_gdp[[tahunku]])
  #   list_negara$features <- lapply(list_negara$features, function(feat){
  #     feat$properties$style <- list(
  #       fillColor = palan(
  #         feat$properties$style <- list(
  #           feat$properties$gdp_per_capita_us[[tahunku]]
  #         )
  #       )
  #     )
  #   })
  #   leaflet() %>% addGeoJSON(list_negara)
  # })
  
  output$lm_diag <- renderText(
    dw_dia$alternative
  )
  output$tulisan_auto <- renderText(
    "Disini membuktikan bahwa mereka memliki autoregressive , 
    berarti harus analisis regresi dan juga harus menyelesaikan dengan memperhatikan
    lag . Dibawah ini adalah hasil dari Koyck , dengan asumsi"
  )
  
  output$kesimpulan <- renderText({
    "Kesimpulannya bahwa dengan mempertimbangkan waktu juga, bahwa sebenarnya 
    keterhubungan jumlah wisatawan dengan GDP percapita berhubungan jika kita
    lihat dari R squared nya."
  })
  
  session$allowReconnect(TRUE)
}