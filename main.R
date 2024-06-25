#librairies/utils/
install.packages("zoo")
library(sf)
library(leaflet)
library(lubridate)
library(zoo)
library(plotly)

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
  mutate(traffic=apt_pax_dep + apt_pax_tr + apt_pax_arr)%>%
  mutate(date=as.yearmon(paste(an,mois,sep="-")))

  
##creation figure pour un aéroport particulier :
### creer reactive pour cette table (input sera apt_nom + an)
airport_all_trans_r<-
  airport_all_trans%>%
  filter(apt_nom=="PARIS-CHARLES DE GAULLE")

airport_traffic<-airport_all_trans_r%>%group_by(date)%>%summarize(traffic=sum(traffic)) ###test reussi 

## Graphique 1
# Evolution traffic aérien par aeroport 
fig <- plot_ly(airport_traffic, x = ~format(as.Date(date),"%Y-%m"), y = ~`traffic`, name = 'traffic', type = 'scatter', mode = 'lines',
               line = list(color = '#1C4E80', width = 4)) 
fig


#valorisation 2 : 
#Tableau HTML pour afficher les données 
  airport_all_trans_r2<-
    airport_all_trans%>%
    filter(an="2022",mois="01")
    
  
  
  








