

#exercice 1
create_data_list<-function(source_file){
  library(yaml)
  list_<-read_yaml(source_file)
  list_
}


