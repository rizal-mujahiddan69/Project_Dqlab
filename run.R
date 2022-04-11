library(shiny)
library(profvis)

port <- Sys.getenv('PORT')

profvis({
shiny::runApp(
    appDir = getwd(),
    host = '0.0.0.0',
    port = as.numeric(port)
) 
})