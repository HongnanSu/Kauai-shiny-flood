library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)
library(dplyr)
library(plotly)
library(DT)

# UI
ui <- dashboardPage(
  dashboardHeader(title = "Kauai Island Flood Dashboard"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Welcome", tabName = "welcome", icon = icon("home")),
      menuItem("Kauai Overview", tabName = "kauai_overview", icon = icon("map")),
      menuItem("Flood Information", tabName = "flood_info", icon = icon("cloud")),
      menuItem("Chart", tabName = "chart", icon = icon("table"))
    )
  ),
  
  dashboardBody(
    tabItems(
      # Welcome Page
      tabItem(tabName = "welcome",
              h1("Welcome to the Kauai Island Flood and Fire Dashboard"),
              tags$img(src = "Napali.jpg", height = "800px", width = "800px")
      ),
      
      # Kauai Overview Page
      tabItem(tabName = "kauai_overview",
              h2("Kauai Island Flood Map"),
              p("Include 2 rain gages and 3 river gages"),
              leafletOutput("kauai_map")
      ),
      
      # Flood Information Page
      tabItem(tabName = "flood_info",
              tabsetPanel(
                tabPanel("Flood Causes and Risks",
                         h2("Flood Causes and Risks on Kauai Island"),
                         p("The primary causes of flooding on Kauai are heavy rainfall and storms, often brought by tropical systems like hurricanes and tropical storms. These weather events can lead to substantial rainfall in short periods, overwhelming the island's drainage systems and causing flash floods. The steep terrain exacerbates this, as water flows quickly down mountains and into the valleys, leading to swift and destructive flooding.

Kauai's rivers, such as the Wailua and Hanalei Rivers, are prone to overflowing during heavy rains, further contributing to flood risks in low-lying areas. In addition to flash floods, Kauai also faces the risk of coastal flooding, particularly during high tides or storm surges associated with tropical storms."),
                         tags$img(src = "11468.jpg", height = "400px", width = "400px")
                ),
                
                tabPanel("Historical Flood Events",
                         h2("Historical Flood Events on Kauai Island"),
                         p("Kauai has experienced several severe flooding events in its history. One of the most significant floods occurred in March 1992, when a tropical storm dumped more than 25 inches of rain in a 24-hour period, causing widespread damage across the island. The flooding affected infrastructure, homes, and agriculture, and resulted in the tragic loss of life.

Another notable event was the flooding caused by Hurricane Iniki in 1992, which brought intense rainfall and winds, devastating parts of the island, especially the western and northern regions. These events highlighted the vulnerability of Kauai's infrastructure to flooding and the need for effective flood control measures."),
                         tags$img(src = "Flooded.jpg", height = "400px", width = "400px")
                ),
                
                tabPanel("Flood Mitigation and Preparedness",
                         h2("Flood Mitigation and Preparedness on Kauai Island"),
                         p("In response to the recurring flooding risks, Kauai has implemented various flood control measures, such as improving drainage systems, constructing levees, and reinforcing riverbanks. Additionally, the island has developed emergency response protocols to ensure residents and visitors are prepared during flood events.

Kauai also conducts regular flood risk assessments and maintains flood maps to identify the most vulnerable areas. This helps guide development and ensures that new construction is built with flood risks in mind. Public education campaigns aim to raise awareness about the dangers of flooding and promote preparedness, especially in flood-prone regions.

Despite these efforts, the island remains at risk, and continued vigilance and adaptation to climate change will be crucial in managing future flood events on Kauai."),
                         tags$img(src = "images.jpg", height = "400px", width = "400px")
                )
              )
      ),
      
      # Data Page
      tabItem(tabName = "chart",
              h2("Rain and River Gage Chart"),
              h3("River gage of SF WailuaRiver nr Lihue"),
              tags$img(src = "WLT1.png", height = "700px", width = "auto"),
              tags$img(src = "WLT2.png", height = "700px", width = "auto"),
              tags$img(src = "WLT3.png", height = "700px", width = "auto"),
              tags$img(src = "WLT4.png", height = "700px", width = "auto"),
              h3("River gage of Hanalei River nr Hanalei"),
              tags$img(src = "DWL.jpg", height = "700px", width = "auto"),
              h3("Hanalei Riv at Hwy 56 Bridge nr Hanalei"),
              tags$img(src = "HFL.png", height = "700px", width = "auto"),
              h3("Rain gages"),
              tags$img(src = "RG1.png", height = "700px", width = "auto"),
              tags$img(src = "RG2.png", height = "700px", width = "auto"),
              
      )
    )
  )
)

# Server
server <- function(input, output, session) {
  # Hanalei River near Hanalei coordinates
  hanalei_coords <- c(22.2093, -159.4972)
  
  # Hanalei River at Hwy 56 Bridge near Hanalei coordinates
  hanalei_bridge_coords <- c(22.2034, -159.4701)
  
  # SF Wailua River near Lihue coordinates
  sf_wailua_coords <- c(21.9760, -159.3552)
  
  # Kilohana coordinates
  kilohana_coords <- c(22.0723, -159.5899)
  
  # Nā Pali Coast (Nā Pali Ale) coordinates
  na_pali_coords <- c(22.1896, -159.6041)
  
  # Map
  output$kauai_map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -159.5261, lat = 22.0964, zoom = 10) %>%
      addCircleMarkers(lng = hanalei_coords[2], lat = hanalei_coords[1], color = "black", popup = "Hanalei River near Hanalei") %>%
      addCircleMarkers(lng = hanalei_bridge_coords[2], lat = hanalei_bridge_coords[1], color = "black", popup = "Hanalei River at Hwy 56 Bridge") %>%
      addCircleMarkers(lng = sf_wailua_coords[2], lat = sf_wailua_coords[1], color = "black", popup = "SF Wailua River near Lihue") %>%
      addCircleMarkers(lng = kilohana_coords[2], lat = kilohana_coords[1], color = "blue", popup = "Kilohana") %>%
      addCircleMarkers(lng = na_pali_coords[2], lat = na_pali_coords[1], color = "blue", popup = "Nā Pali Coast (Nā Pali Ale)")
  })
}

shinyApp(ui = ui, server = server)
