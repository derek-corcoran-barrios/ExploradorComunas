#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(sf)
library(leaflet)
library(dplyr)

Comunas <- read_sf("AllCities.shp")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Explorador de comunas"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectizeInput("Comuna",
                        "Selecciona tu ciudad de interés:",
                        choices = Comunas$Ciudad)
        ),

        # Show a plot of the generated distribution
        mainPanel(
          leaflet::leafletOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- leaflet::renderLeaflet({
      
      Polis <- Comunas %>% 
        dplyr::filter(Ciudad == input$Comuna)
        
        
      leaflet() %>% 
        addProviderTiles("Esri.WorldImagery") %>% 
        leaflet::addPolygons(data = Polis)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
