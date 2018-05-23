library(jsonlite)
library(lubridate)
library(dplyr)
uiuc_weather_raw1 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4806&since=2016-03-01&until=2018-12-31")
uiuc_weather1 <- uiuc_weather_raw1$properties

uiuc_weather_raw2 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4807&since=2016-03-01&until=2018-12-31")
uiuc_weather2 <- uiuc_weather_raw2$properties

uiuc_weather_raw3 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4808&since=2016-03-01&until=2018-12-31")
uiuc_weather3 <- uiuc_weather_raw3$properties

# plot(uiuc_weather1$air_temperature)

# ymd_hms() conversion