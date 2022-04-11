library(mice)
library(readxl)
library(tidyverse)
library(leaflet)
library(jsonlite)
library(lmtest)
library(dLagM)
library(forecast)
library(shiny)
library(magrittr)
library(ggplot2)


data_sheet <- as.tibble(read.csv("Data_Ind.csv"))
data_sheet <- data_sheet %>% select(-c(X))
head(data_sheet)

data_world <- read_excel("Data_World.xlsx",sheet="Data")
data_world_gdp <- read.csv("data_world_gdp.csv")

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