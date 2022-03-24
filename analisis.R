library(mice)
library(readxl)
library(tidyverse)
#library(leaflet)
library(jsonlite)
library(lmtest)
library(dLagM)
library(forecast)

data_sheet <- read_excel("Data_Indonesia.xls",sheet="Data",skip=2)
names(data_sheet) <- make.names(names(data_sheet))
data_sheet <- data_sheet %>% select(-c("Indicator.Code",
                                       "Country.Code","Country.Name"))

yearku <- names(data_sheet)[-c(1)]
data_sheet <- data_sheet %>% pivot_longer(yearku,names_to = "year")

data_sheet$year <- sapply(data_sheet$year,function(x){substr(x,2,nchar(x))})
data_sheet$year <- as.numeric(data_sheet$year)
data_sheet <- data_sheet %>% 
  pivot_wider(names_from = Indicator.Name,
              values_from = value)

names(data_sheet) <- make.names(names(data_sheet))
names(data_sheet) <- str_replace_all(names(data_sheet),"(\\.){2,}",".")
data_sheet <- data.frame(data_sheet)
rownames(data_sheet) <- data_sheet$year
data_sheet <- as_tibble(data_sheet)
data_sheet <- data_sheet %>% select_if(~!all(is.na(.)))

data_metadata <- read_excel("Data_Indonesia.xls",
                            sheet="Metadata - Indicators")

data_metadata <- data_metadata %>% 
                    select(-c(INDICATOR_CODE,SOURCE_ORGANIZATION))


# data_world <- read_excel("Data_World.xlsx",sheet="Data")
# names(data_world) <- make.names(names(data_world))
# 
# peletakan <- str_extract(names(data_world)[5:length(data_world)],"(\\d)+")
# peletakan <- c(names(data_world)[1:4],peletakan)
# colnames(data_world) <- peletakan
# 
# data_world_gdp <- data_world %>% 
#   select(-c(Country.Code,`Series.Code`)) %>% 
#   filter(Series.Name == "GDP per capita (current US$)") %>% 
#   select(-c(Series.Name))
# 
# 
# for(kolomku in (names(data_world_gdp)[3:dim(data_world_gdp)[2]])){
#   data_world_gdp[[kolomku]] <- as.numeric(data_world_gdp[[kolomku]])
# } 


y_hitung = data_sheet$GDP.per.capita.current.US.
x_hitung = data_sheet$International.tourism.number.of.arrivals

setx <- which(!is.na(x_hitung))
sety <- which(!is.na(y_hitung))
set_all <- intersect(setx,sety)

x_hitung <- x_hitung[set_all]
y_hitung <- y_hitung[set_all]

linear_regression <- lm(y_hitung ~ x_hitung)
summary(linear_regression)

dw_dia <- dwtest(linear_regression)

koyck_model <- koyckDlm(x=x_hitung,y=y_hitung)
summary(koyck_model)



# str_json <- "geojson_world.json"
# 
# geojson <- readLines(str_json, warn = FALSE) %>%
#   paste(collapse = "\n") %>%
#   fromJSON(simplifyVector = FALSE)
# 
# 
# nama_neg_geojson <- c()
# banyak_negara <- length(geojson$features)
# for(negara in 1:banyak_negara){
#   nama_negara <- geojson$features[[negara]]$properties$name
#   nama_neg_geojson <- c(nama_neg_geojson,nama_negara)
# }
# 
# 
# negaraku <- intersect(nama_neg_geojson,data_world_gdp$Country.Name)
# data_world_gdp <- data_world_gdp %>% 
#                     filter(Country.Name %in% negaraku)
# 
# banyak_negara <- length(geojson$features)
# list_negara <- list(features=list())
# cc <- 1
# 
# for(negara in 1:banyak_negara){
#   nama_negara <- geojson$features[[negara]]$properties$name
#   if(nama_negara %in% negaraku){
#     list_negara$features[[cc]] <- geojson$features[[negara]]
#     cc <- cc+1
#   }
# }
# 
# list_negara$style = list(
#   weight = 1,
#   color = "#555555",
#   opacity = 1,
#   fillOpacity = 0.8
# )
# 
# 
# banyak_negara <- length(list_negara$features)
# for(negara in 1:banyak_negara){
#   nama_negara <- list_negara$features[[negara]]$properties$name
#   for(i in 1960:2020){
#     namanya <- as.name(i)
#     negara_tahun <- data_world_gdp %>% 
#       filter(Country.Name == nama_negara) %>% 
#       select(namanya)
#     list_negara$features[[negara]]$properties$gdp_per_capita_us[[namanya]] <- negara_tahun 
#   }
# }