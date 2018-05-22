# meteorological meta-data is here: 
# https://docs.terraref.org/user-manual/data-products/environmental-conditions#variable-names-and-units

library(jsonlite)
library(dplyr)
library(lubridate)

uiuc_weather.list <- jsonlite::fromJSON('https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4807&since=2017-01-02&until=2017-01-31')

uiuc_weather <- uiuc_weather.list$properties

uiuc_weather_time <- uiuc_weather.list %>% 
  select(start_time, end_time) %>% 
  mutate(start = ymd_hms(start_time), end = ymd_hms(end_time)) %>% 
  rowwise() %>% 
  transmute(time = mean(c(start, end)))

## append the time column
## write out as csv