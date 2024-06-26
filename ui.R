mytheme <- create_theme(
  adminlte_color(
    light_blue = "#003366"
  ),
  adminlte_sidebar(
    width = "400px",
    dark_bg = "#ADD8E6",
    light_hover_color  ="#FFA500",
    dark_color = "#ADD8E6"
  ),
  adminlte_global(
    content_bg = "#ccd6e0",
    box_bg = "#f8f9fa", 
    info_box_bg = "#f8f9fa"
  )
  
)

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
  selectInput(inputId = "aeroport",label="Aéroport choisi",
              choices = unique(airport_all$apt_nom),
              selected ="PARIS-CHARLES DE GAULLE")


header <- dashboardHeader(
  title=strong("Tableau de bord trafic aérien")
)
#########################################################################################

##Objectif : elargir sidebar
sidebar<-dashboardSidebar(
  input_date,
  input_aeroport
)


#########################################################################################

body <- dashboardBody(
  tags$head(
    tags$style(HTML("
      .lien-comme-bouton {
        padding: 10px 15px;
        background-color: #003366;
        color: white;
        border: none;
        text-decoration: none;
        margin: 5px;
        border-radius: 5px;
        display: inline-block;
      }
      .lien-comme-bouton:hover {
        background-color: #F6B26B;
      }
    "))
  ), #fin tags$head (element css)
  use_theme(mytheme),
  tabsetPanel(
    tabPanel(
      "Trafic aéroports",
      fluidRow(
        column(
          width=6,
          box(
            title="Carte fréquentation aéroports(mensuel)",width=NULL,solidHeader=TRUE,status="primary",leafletOutput("output3")%>%withSpinner()
          ),
          box(
            title="Top 10 aéroports les plus frequentés(mensuel)",width=NULL,solidHeader=TRUE,status="primary",DTOutput("output2")%>%withSpinner()
          )
        ),
        column(
          width=6,
          box(
            title="Evolution du nombre de passagers par aéroport",width=NULL,solidHeader=TRUE,status="primary",plotlyOutput("output1")%>%withSpinner()
          ),
          box(
            title="Evolution du volume de fret par aéroport(en tonnes)",width=NULL,solidHeader=TRUE,status="primary",plotlyOutput("output1_2")%>%withSpinner()
          )
        )
      )
      
    ),#fin 2e panel
    tabPanel(
      "Trafic liaisons"
    )#fin 3e panel (Orientation des auteurs)
    
    
  ) #fin de ts les panels
)#fin body

