# https://datascienceplus.com/metro-systems-over-time-part-1/

library(dplyr)
library(tidyr)
library(ggmap)

data = read.table("https://raw.githubusercontent.com/pagepiccinini/blog/master/2016-09-27_metros/data_metros.txt", header=T, sep="\t") %>%
  unite(geo_location, c(station, location), sep = ", ", remove = FALSE) %>%
  separate(opened, into = c("opened_month", "opened_day", "opened_year"), sep = "/") %>%
  mutate_geocode(geo_location, source = "google")

# data <- read.table("https://raw.githubusercontent.com/pagepiccinini/blog/master/2016-09-27_metros/data_metro_full.txt", header=T, sep="\t")
# head(data)

paris_map = get_googlemap(center = "Paris", maptype = "roadmap",
                          zoom = 11, size = c(640, 420), color = "bw")

berlin_map = get_googlemap(center = "Berlin", maptype = "roadmap",
                           zoom = 10, size = c(640, 420), color = "bw")

barcelona_map = get_googlemap(center = "Barcelona", maptype = "roadmap",
                              zoom = 11, size = c(640, 420), color = "bw")

prague_map = get_googlemap(center = "Prague", maptype = "roadmap",
                           zoom = 11, size = c(640, 420), color = "bw")

city_plot = function(city_name, city_map){
  ggmap(city_map, extent = "device") +
    geom_point(data = subset(data, city == city_name), aes(x = lon, y = lat),
               color = "#0571b0", size = 3)
}

paris.plot = city_plot("Paris", paris_map)
paris.plot