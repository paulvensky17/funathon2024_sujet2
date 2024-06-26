#ui

input_date <- shinyWidgets::airDatepickerInput(
  "date",
  label = "Mois choisi",
  value = "2019-01-01",
  view = "months",
  minView = "months",
  minDate = "2018-01-01",
  maxDate = "2022-12-01",
  dateFormat = "MMMM yyyy",
  language = "fr"
)

input_aeroport<-
  selectInput(inputId = "aeroport",label="Aéroport choisi",choices = unique(airport_all$apt_nom),selected ="PARIS-CHARLES DE GAULLE")

#theme <- bs_theme(bg = "#6c757d", fg = "white", primary = "orange")

ui<-
  fluidPage(
    #theme=theme,
    theme=bs_theme(bootswatch="slate"),
    
    fluidRow(
      fluidRow(
        column(10),
        column(2,input_date)
      ),
      fluidRow(
        column(6,
               h3("Carte trafic aérien"),
               leafletOutput("output3")),
        column(6,
               h3("Classement des aéroports selon la fréquentation"),
               DTOutput("output2"))
      )
    ),
    fluidRow(
      column(2,input_aeroport),
      column(10,
             h3("Evolution du trafic aérien dans le temps (par aéroport)"),
             plotlyOutput("output1"))
    )
  )
