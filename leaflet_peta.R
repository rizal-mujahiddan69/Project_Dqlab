# Tampilan map
library(mapview)
library(leaflet)
source("analisis.R")

geojson <- readLines("geojson_world.json", 
                     warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)


nama_neg <- list()
nam_ku <- c()

for(country in geojson$features){
  kolom_geojson <- country$properties$name
  if( (kolom_geojson %in% data_world_gdp$Country.Name) == TRUE){
    # cekhasil <- list(type=country$type,id=country$id,
    #                  properties=country$properties,
    #                  geometry=country$geometry)
    # nama_neg <- append(nama_neg,list(cekhasil))
    nam_ku <- c(nam_ku,kolom_geojson)
  }
}

geojsonku <- list(type="FeatureCollection",
                  features = nama_neg)

data_world_gdpku <- data_world_gdp %>% filter(Country.Name %in% nam_ku) %>% 
                      arrange(Country.Name)


# Default styles for all features
geojson$style = list(
  weight = 0.2,
  color = "#000000",
  opacity = 1,
  fillOpacity = 0.8
)

data_world_gdpku <- data_world_gdpku %>% replace(is.na(.), 0)

# Color by per-capita GDP using quantiles
pal <- colorQuantile("Blues", data_world_gdpku$`2020`)

for(i in 1:length(geojson$features)){
  nama_negara <- geojson$features[[i]]$properties$name
  hasilwarna = data_world_gdpku[data_world_gdpku["Country.Name"]==nama_negara,
                                "2020"]
  hasilwarna = hasilwarna$`2020`
  if(length(hasilwarna)==0){
    hasilwarna = 0
  }
  geojson$features[[i]]$properties$style <- list(
    fillColor = pal(
      hasilwarna
    )
  )
}

# Add the now-styled GeoJSON object to the map
peta_gdp <- leaflet()  %>% setView(lng=0,lat=0,zoom=1.2) %>% 
              addGeoJSON(geojson,opacity=0.2) %>% 
              addControl("Sebaran GDB Di Dunia pada 2022 ($ USD)","topright") %>% 
              addLegend(pal=pal,values = data_world_gdpku$`2020`,
                        position = "bottomright")

peta_gdp
mapshot(peta_gdp, file = "www/image/peta_gdp.png")