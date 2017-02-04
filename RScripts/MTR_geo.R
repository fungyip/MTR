# install.packages("deldir")
library(tidyverse)
library(ggmap)
library(purrr)
library(deldir)

#Data Import
mtr <- read_csv("./DataIn/HK_POI_MTR.csv")  
  
#MTR Adddress Geocoding
names(mtr)
head(mtr)
mtr_address<-mtr$Address
x<-geocode(mtr_address)
mydata<-cbind(mtr,x)

write_csv(mydata,"./DataIn/HK_POI_MTR_geo.csv")

# mydata1 = read_csv("./DataIn/HK_POI_MTR.csv") %>%
#           mutate_geocode(Address, source = "google")

#Get Hong Kong Map
HK_map_color = get_googlemap(center = "Hong Kong", maptype = "roadmap",
                          zoom = 11, size = c(640, 420), color = "color")

HK_map_bw = get_googlemap(center = "Hong Kong", maptype = "roadmap",
                             zoom = 11, size = c(640, 420), color = "bw")

mydata_deldir = mydata %>% 
  nest(-District, .key = location_info) %>%
  mutate(deldir = map(location_info, function(df) deldir(df$lon, df$lat))) %>%
  mutate(del.area = map(deldir, "del.area")) %>%
  mutate(delsgs = map(deldir, "delsgs")) %>%
  mutate(summary = map(deldir, "summary"))
mydata_deldir

mydata_deldir_delsgs = mydata_deldir %>%
  select(District, delsgs) %>%
  unnest()
head(mydata_deldir_delsgs)


mydata_deldir_cent = mydata_deldir %>%
  select(District, summary) %>%
  unnest() %>%
  group_by(District) %>%
  summarise(cent_x = sum(x * del.wts),
            cent_y = sum(y * del.wts)) %>%
  ungroup()
mydata_deldir_cent


#DataVis
del_plot = function(city_name, city_map){
  ggmap(city_map, extent = "device") +
    geom_segment(data = subset(data_deldir_delsgs, city == city_name), aes(x = x1, y = y1, xend = x2, yend = y2),
                 size = 1, color= "#92c5de") +
    geom_point(data = subset(data, city == city_name), aes(x = lon, y = lat),
               color = "#0571b0", size = 3) +
    geom_point(data = subset(data_deldir_cent, city == city_name),
               aes(x = cent_x, y = cent_y),
               size = 6, color= "#ca0020")
}

paris_del.plot = del_plot("Paris", paris_map)
paris_del.plot

