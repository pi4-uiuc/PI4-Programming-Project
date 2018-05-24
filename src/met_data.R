# meteorological meta-data is here: 
# https://docs.terraref.org/user-manual/data-products/environmental-conditions#variable-names-and-units

library(jsonlite)
library(dplyr)
library(lubridate)

uiuc_weather_raw1 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4806&since=2016-03-01&until=2018-12-31")
uiuc_weather1 <- uiuc_weather_raw1$properties

uiuc_weather_raw2 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4807&since=2016-03-01&until=2018-12-31")
uiuc_weather2 <- uiuc_weather_raw2$properties

uiuc_weather_raw3 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4805&since=2016-03-01&until=2018-12-31")
uiuc_weather3 <- uiuc_weather_raw3$properties

## Example code for averaging time

uiuc_weather.list <- jsonlite::fromJSON('https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4807&since=2017-01-02&until=2017-01-31')

uiuc_weather <- uiuc_weather.list$properties

uiuc_weather_time <- uiuc_weather.list %>% 
  select(start_time, end_time) %>% 
  mutate(start = ymd_hms(start_time), end = ymd_hms(end_time)) %>% 
  rowwise() %>% 
  transmute(time = mean(c(start, end)))

## append the time column
## write out as csv
