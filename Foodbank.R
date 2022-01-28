library(tidyverse)
library(leaflet)
library(leaflet.extras)



#Read in the data
data <- read_csv("Foodbank.csv")

View(data)

data <- data %>%  
  mutate(popup_info = paste(Location, "<br/>", Address, "<br/>",Phone))


#Create colors based on type (Blue ~ Foodbank, Green~ Groc stores & Red ~ Fire Dept)
new <- c("blue", "green","red")[data$Type]
pal <- colorNumeric(c("blue", "green","red"),data$Type)


#Change properties to add color to addAwesomeMarkers
icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = new
  )

#Produce map
mymap <- leaflet(data = data) %>% 
  addTiles() %>% 
  addProviderTiles("OpenStreetMap", group = "OpenStreetMap") %>% 
  setView(lng = -78.94616, lat = 43.88701, zoom = 12) %>% 
  addAwesomeMarkers(lng=~Long, lat=~Lat, icon=icons, popup = ~popup_info) %>% 
  addLegend(position = "bottomright", colors = c("blue", "green","red"), labels = c("FoodBank", "Grocery Stores", "Fire Dept"), title = "Services & Partners") %>%
  addResetMapButton()
  
  