# This code compares the data sets from the link provided with corresponding data
# sets in daymet to give some insights on detecting the corrupted data.
# It compares temperature and precipitation. 
library(jsonlite)
library(dplyr)
library(lubridate)
library(ggplot2)
library(purrr)
library(fitdistrplus)
library(daymetr)


# # getting data from the link and the corresponding data from daymet.
# all_weather_data <- function(link){
#   # Getting data from the link
#   select <- dplyr::select
#   weather_raw <- fromJSON(txt = link)
#   weather <- weather_raw$properties
  
# Downloading DAYMET data for: the weather station in the link at latitude/longitude   
df <- download_daymet(site = "UA-MAC AZMET Weather Station",
                      lat = as.numeric(33.0745666667),
                      lon = as.numeric(-111.9750833333),
                      start = 2016,
                      end = 2017,
                      internal = TRUE)
  
df_data1 <- df[6]
df_data <- data.frame(df_data1)
  
daymet <- df_data %>% mutate(date = ymd(paste0(data.year, '-01-01')) 
                            + days(df_data$data.yday -1))
  

met <- readr::read_csv("data/uiuc_met.csv")
unique(met$site)

AZ_met <- met %>% filter(site == "UA-MAC AZMET Weather Station") %>% 
  rename(meantime = time, temp = air_temperature) %>% 
  mutate(date = date(meantime), temp = temp- 273.15) %>% 
  select(meantime, date, temp)


n = AZ_met %>% left_join(daymet)
m <- n %>% mutate(temp = temp) %>% 
  dplyr::select(meantime, temp, tmax = data.tmax..deg.c., 
                tmin = data.tmin..deg.c.) %>% 
  mutate(ok = temp <= tmax + 3 & temp >= tmin -3, 
         month = month(meantime), 
         year = year(meantime),
         ok2 = abs(0.5-pnorm(temp - (tmin+tmax)/2, mean = 0, sd = 10))) 

ggplot(data= m, aes(x= meantime))+
  geom_point(aes(y = temp, color = ok2))+
  geom_line(aes(y = tmax))+
  geom_line(aes( y = tmin))+
  geom_line(aes( y = tmax + 3), linetype = 2)+
  geom_line(aes( y = tmin - 3), linetype = 2)+
  facet_wrap(~year+month, scales = 'free_x')
