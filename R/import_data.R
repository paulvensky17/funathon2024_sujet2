
#function 1 : import and clean airport data 

import_airport_data<-function(list_files){
  
  library(readr)
  #etape 1 : lecture des données
  urls<-create_data_list("sources.yml")
  
  aeroport_url<-unlist(urls$airports)
  
  aeroports<-read_csv2(aeroport_url,col_types = cols(
    ANMOIS = col_character(),
    APT = col_character(),
    APT_NOM = col_character(),
    APT_ZON = col_character(),
    .default = col_double()
  ))
  
  #etape 2 
  aeroport_cleaned<-
    clean_dataframe(aeroports)
  
  aeroport_cleaned
  
  
  
  
}



#function 2 : import and clean companies data 

import_compagnies_data<-function(list_files){
  
  library(readr)
  
  #etape 1 : lecture des données
  urls<-create_data_list("sources.yml")
  
  compagnies_url<-unlist(urls$compagnies)
  
  compagnies<-read_csv2(compagnies_url,col_types = cols(
    ANMOIS = col_character(),
    CIE = col_character(),
    CIE_NOM = col_character(),
    CIE_NAT = col_character(),
    CIE_PAYS = col_character(),
    .default = col_double()
  ))
  
  #etape 2 
  compagnies_cleaned<-
    clean_dataframe(compagnies)
  
  compagnies_cleaned
  
  
  
  
}


#function 3 :Import and clean liaisons data
 
import_liaisons_data<-function(list_files){
  
  library(readr)
  
  #etape 1 : lecture des données
  urls<-create_data_list("sources.yml")
  
  liaisons_url<-unlist(urls$liaisons)
  
  liaisons<-read_csv2(liaisons_url,col_types = cols(
    ANMOIS = col_character(),
    LSN = col_character(),
    LSN_DEP_NOM = col_character(),
    LSN_ARR_NOM = col_character(),
    LSN_SCT = col_character(),
    LSN_FSC = col_character(),
    .default = col_double()
    
  ))
  
  #etape 2 
  liaisons_cleaned<-
    clean_dataframe(liaisons)
  
  liaisons_cleaned
  
}



