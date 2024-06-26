#server
######################################################
server<-function(input,output,session){
  
  reactive1<-reactive({
    airport_all_trans_r<-
      airport_all_trans%>%
      filter(apt_nom==input$aeroport)
  })
  
  output$output1<-renderPlotly({
    
    airport_traffic_passager_fret<-
      reactive1()%>%
      group_by(date)%>%
      summarize(
        traffic_passager=sum(traffic_passager),
        traffic_fret=sum(traffic_fret)
      )
    
    ## Graphique 1
    # Evolution traffic aérien par aeroport (passager et fret si possible)
    fig <- plot_ly(airport_traffic_passager_fret, x = ~format(as.Date(date),"%Y-%m"), y = ~`traffic_passager`, name = 'Trafic total de passagers', type = 'scatter', mode = 'lines',
                   line = list(color = '#1C4E80', width = 4)) 
    
    #ajouter la seconde trace avec un axe secondaire
    fig <- fig %>% add_trace(y = ~`traffic_fret`, name = 'Volume de fret total (en tonnes)', type = 'scatter', mode = 'lines', yaxis = 'y2',
                             line = list(color = '#EA6A47', width = 4)) 
    
    #configuration axes
    fig<-
      fig%>%
      layout(
        yaxis=list(title="Trafic total de passagers"),
        yaxis2=list(
          title="Volume de fret total (en tonnes)", 
          overlaying="y",
          side="right"
        ),
        xaxis=list(
          title="Année-Mois",
          tickformat = "%Y-%m",
          tickmode = "array",
          tickvals = seq(as.Date("2018-01-01"), as.Date("2023-01-01"), by="3 month"),
          ticktext = format(seq(as.Date("2018-01-01"), as.Date("2023-01-01"), by="3 month"), "%Y-%m"),
          tickangle = -45,
          tickfont = list(size=8)
        )
      )
    
    fig
  })
  
  reactive2<-reactive({
    airport_all_trans_r2<-
      airport_all_trans%>%
      mutate(date_format=as.Date(date))%>%
      filter(date_format==input$date)
  })
  
  output$output2<-renderDT({
    
    airport_nbre_passager_table<-
      reactive2()%>%
      group_by(apt,apt_nom)%>%
      summarise(
        départs=sum(apt_pax_dep),
        arrivé=sum(apt_pax_arr),
        transit=sum(apt_pax_tr)
      )%>%
      mutate(total=départs+arrivé+transit)%>%
      arrange(desc(total))%>%
      select(-total)%>%
      ungroup()%>%
      mutate(Aéroports=paste(apt_nom,"(",apt,")",sep=""))%>%
      select(Aéroports,départs,arrivé,transit)
    
    airport_nbre_passager_table<-
      datatable(head(airport_nbre_passager_table,10), class = 'cell-border stripe',options = list(dom = 't'))
    
    airport_nbre_passager_table
    
  })
  
  output$output3<-renderLeaflet({
    
    trafic_aero<-
      reactive2()%>%
      mutate(total_passager=apt_pax_dep+apt_pax_arr+apt_pax_tr)%>%
      select(apt,apt_nom,total_passager)
    
    ###jointure 
    table_carto<-
      airports_location_transformed%>%
      left_join(trafic_aero,by=c("Code.OACI"="apt"))
    
    
    ### Réalisation de la carte 
    carto<-
      leaflet(table_carto) %>%
      addProviderTiles(provider = "OpenStreetMap") %>%
      addMarkers(
        popup = ~paste0(
          "<b>", apt_nom, "</b><br>",
          "Total voyageurs: ", total_passager
        ),
        icon = makeAwesomeIcon(
          icon = "plane",
          markerColor = "blue",
          iconColor = "white",
          library = "fa"
        )
      ) %>%
      addLegend(
        position = "bottomright",
        title = "Légende",
        colors = "blue",
        labels = "Aéroports"
      ) %>%
      addScaleBar(
        position = "bottomleft",
        options = scaleBarOptions(
          metric = TRUE,
          imperial = FALSE
        )
      ) 
    
    carto
    
  })
  
  
}