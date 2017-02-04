---
Title: "MTR Metro Development Over Time 港鐵路線圖"
Author: "Fung YIP"
Date: "04 Feb 2017"
Analytics: 
  Web Scraping: XML
  GIS: Geocoding
  Data Viz: Gif
---

## Introduction
This repository is created to visualise the development of MTR stations in Hong Kong since 1910 based on the tables available on Wiki <https://en.wikipedia.org/wiki/List_of_MTR_stations>.


## Data Visualisation

#### Result
The first railway was to connect between Mainland China and Hong Kong and then there was a development of Kowloon side area in the late 70s. Hong Kong Island witnessed the expansion of MTR stations later in the 80s. 

Development of MTR Stations over time

&nbsp; 
&nbsp; 
&nbsp; 
![MTR Stations](./DataOut/MTRMapOverTime.gif)


## 2. Problem Solving
####2.1 Using Web Scraping technique and Geocoding in order to identify station locations.
 
Wiki
<https://en.wikipedia.org/wiki/List_of_MTR_stations>

```{r Data Collection Wiki , echo=TRUE, eval=FALSE, message=FALSE, warning=FALSE}

library(tidyverse)
library(ggmap)
library(gganimate)

#Data Import
mtr <- read_csv("./DataIn/HK_POI_MTR.csv")  

#MTR Adddress Geocoding
names(mtr)
head(mtr)
mtr_address<-mtr$Address
x<-geocode(mtr_address)
mydata<-cbind(mtr,x)

write_csv(mydata,"./DataIn/HK_POI_MTR_geo.csv")
mydata <- read_csv("./DataIn/HK_POI_MTR_geo.csv")
```


####2.2 Data Viz
```{r Data Viz, echo=TRUE, eval=FALSE, message=FALSE, warning=FALSE}
#Get Hong Kong Map
HK_map_color = get_googlemap(center = "Hong Kong", maptype = "roadmap",
                             zoom = 11, size = c(640, 420), color = "color")

HK_map_bw = get_googlemap(center = "Hong Kong", maptype = "roadmap",
                          zoom = 11, size = c(640, 420), color = "bw")

MTROverTime = function(city_map){
  ggmap(city_map, extent = "device") +
    geom_point(data = mydata,
               aes(x = lon, y = lat, frame = Opened, cumulative = TRUE),
               color = "blue", size = 3) 
}

plot <- MTROverTime(HK_map_color)
plot
gganimate(plot,"./DataOut/MTRMapOverTime.gif")

```

