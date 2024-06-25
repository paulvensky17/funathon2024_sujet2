#function 2 : cleaning dataframe

clean_dataframe<-function(datatoclean){
  library(dplyr)
  
  data_cleaned<-
    datatoclean%>%
    mutate(an=substr(ANMOIS,1,4),mois=substr(ANMOIS,5,6))
  
  colnames(data_cleaned) <- tolower(colnames(data_cleaned))
  
  data_cleaned
  
}


