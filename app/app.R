library(shiny)
library(leaflet)

ui <- fluidPage(
  titlePanel("Gießen HDN Test MAP"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("buildings", "Choose Buildings:",
                         choices = list("Hauptgebäude" = "hauptgebäude",
                                        "Philosophikum Campus" = "philosophikum"),
                         selected = c("hauptgebäude", "philosophikum"))
    ),
    mainPanel(
      leafletOutput("map")
    )
  )
)

server <- function(input, output) {
  output$map <- renderLeaflet({
    map <- leaflet() %>% 
      addTiles()  # Add default OpenStreetMap map tiles
    
    
    # Check if Hauptgebäude is selected
    if ("hauptgebäude" %in% input$buildings) {
      map <- map %>% addMarkers(lat = 50.580573, 
                                lng = 8.676874,
                                popup = "Hauptgebäude")
    }
    
    # Check if Philosophikum is selected
    if ("philosophikum" %in% input$buildings) {
      map <- map %>% addMarkers(lat = 50.573764,
                                lng = 8.700415,
                                popup = "Philosophikum Campus")
    }
    
    map  # Return the map
  })
}

shinyApp(ui = ui, server = server)
