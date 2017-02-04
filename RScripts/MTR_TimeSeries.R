# install.packages("deldir")
devtools::install_github("dkahle/ggmap")
devtools::install_github("hadley/ggplot2")
devtools::install_github("dgrtwo/gganimate")

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

# Once you've figured out the correct types
mydata_spec <- write_rds(spec(mydata), "mydata.rds")

mydata <- read_csv("./DataIn/HK_POI_MTR_geo.csv",
          col_types = read_rds("mydata.rds")
          )

# mydata1 = read_csv("./DataIn/HK_POI_MTR.csv") %>%
#           mutate_geocode(Address, source = "google")

#Get Hong Kong Map
HK_map_color = get_googlemap(center = "Hong Kong", maptype = "roadmap",
                             zoom = 11, size = c(640, 420), color = "color")

HK_map_bw = get_googlemap(center = "Hong Kong", maptype = "roadmap",
                          zoom = 11, size = c(640, 420), color = "bw")


time_plot = function(district_name, city_map){
  ggmap(city_map, extent = "device") +
    geom_point(data = subset(mydata, District == district_name),
               aes(x = lon, y = lat, frame = Opened, cumulative = TRUE),
               color = "#0571b0", size = 3) 
}

plot = time_plot("Hong Kong", HK_map_bw)
plot
gganimate(plot)


ggmap(paris, extent = "device")


geom_segment(data = subset(time_deldir_delsgs_sub, city == city_name),
             aes(x = x1, y = y1, xend = x2, yend = y2, frame = opened_year),
             size = 1, color= "#92c5de") +
  


