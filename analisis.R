library(mice)
library(readxl)
library(tidyverse)
library(visdat)

data_sheet <- readxl::read_excel("Data_World.xls",sheet="Data",skip=2)
cek <- dim(data_sheet)

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

