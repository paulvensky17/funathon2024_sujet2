# setup

#install.packages("zoo")
#install.packages("kableExtra")
#install.packages("bslib")
#install.packages("bsicons")
library(shiny)
library(shinyWidgets)
library(bslib)
library(sf)
library(leaflet)
library(lubridate)
library(zoo)
library(plotly)
library(DT)
library(kableExtra)
library(bslib)

source("~/work/funathon 2024 projet 2/R/create_data_list.R")
source("~/work/funathon 2024 projet 2/R/clean_dataframe.R")
source("~/work/funathon 2024 projet 2/R/import_data.R")

urls<-create_data_list("sources.yml")

airport_all<-import_airport_data("source.yml")
companies_all<-import_compagnies_data("source.yml")
liaison_all<-import_liaisons_data("source.yml")

airports_location<-st_read(urls$geojson$airport)

#Exploration des données 

#frequentation des aéroports
airport_all_trans<-
  airport_all%>%
  mutate(traffic_passager=apt_pax_dep + apt_pax_tr + apt_pax_arr)%>%
  mutate(traffic_fret=apt_frp_dep + apt_frp_arr)%>%
  mutate(date=as.yearmon(paste(an,mois,sep="-")))

airports_location_transformed<-
  airports_location%>%
  distinct(Code.OACI,.keep_all = TRUE)%>%
  select(Code.OACI,color,geometry)




