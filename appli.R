source(file = "~/work/funathon 2024 projet 2/setup.R")
source(file = "~/work/funathon 2024 projet 2/server.R")
source(file="~/work/funathon 2024 projet 2/ui.R")

ui_comp=ui
server_comp=server

# Run the application 
shinyApp(ui = ui_comp, server = server_comp)


