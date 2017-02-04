library(rvest)
library(tidyverse)
url = "https://en.wikipedia.org/wiki/List_of_MTR_stations"

# All <- read_html(url, encoding="UTF-8") %>% html_nodes(xpath="//tr/td") %>%
#   html_text() %>% 
#   as.data.frame()

# Name <- read_html(url, encoding="UTF-8") %>% html_nodes("td:nth-child(2) a") %>%
#   html_text() %>% 
#   as.data.frame()
# 
# District <- read_html(url, encoding="UTF-8") %>% html_nodes("tr :nth-child(5)") %>%
#   html_text() %>% 
#   as.data.frame()
# 
# Opened <- read_html(url, encoding="UTF-8") %>% html_nodes("tr :nth-child(6)") %>%
#   html_text() %>% 
#   as.data.frame()
# 
# Code <- read_html(url, encoding="UTF-8") %>% html_nodes("tr :nth-child(7)") %>%
#   html_text() %>% 
#   as.data.frame()
# 
# Photo <- read_html(url, encoding="UTF-8") %>% html_nodes("td:nth-child(3) a") %>%
#   html_attr("src")

All_long <- read_html(url, encoding="UTF-8") %>% html_nodes(xpath="//tr") %>%
  html_text() %>% 
  as.character()

All_long_v1 <- strsplit(All_long, "\\n")

All <- as.data.frame(matrix(unlist(All_long_v1), nrow=length(unlist(All_long_v1[1]))))
All_t <- t(All) %>% 
  as.data.frame()

write_csv(All_t,"./DataIn/WebScraping.csv")


# #Select DataFrame - East Rail Line
# East_Rail <- dd[1:8, c(2:15)]
# East_Rail_t <- t(East_Rail)
# 
# #Select DataFrame - Kwun Tong LIne
# Kwun_Tong <- dd[1:8, c(17:33)]
# Kwun_Tong_t <- t(Kwun_Tong)
# 
# #Select DataFrame - Tsuen Wan LIne
# Tsuen_Wan <- dd[1:8, c(35:47)]
# Tsuen_Wan_t <- t(Tsuen_Wan)
# 
# Tsuen_Wan_2 <- dd[1:8, c(48:50)]
# Tsuen_Wan_2_t <- t(Tsuen_Wan_2)
# 
# #Select DataFrame - Island LIne
# Island <- dd[1:8, c(52:66)]
# Island_t <- t(Island)

##Other Data Manuplication Techniques 
home<-lapply(All_long_v1,rbind) 
All_long_v1[1:123]
aa<-t(dd)
my.matrix<-do.call("rbind", All_long_v1)
a.matrix<-do.call("cbind", All_long_v1)








