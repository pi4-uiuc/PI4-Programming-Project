# meteorological meta-data is here: 
# https://docs.terraref.org/user-manual/data-products/environmental-conditions#variable-names-and-units

library(jsonlite)
library(dplyr)
library(lubridate)

# can use parameters &since=2016-03-01&until=2018-12-31 to subset data

rawmet <- list()
for(stream_id in c(3211, 4806, 4807, 4805)){
  z <- fromJSON(paste0("https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?stream_id=", stream_id))
  time <-  z %>% 
    dplyr::select(start_time, end_time) %>% 
    mutate(start = ymd_hms(start_time), end = ymd_hms(end_time)) %>% 
    rowwise() %>% 
    transmute(time = mean(c(start, end)))
  sitename <- z$sensor_name
  properties <- z$properties %>% select(-starts_with('source'))
  met <- properties
  rawmet[[sitename[1]]] <- bind_cols(time, site = sitename, properties)
}


library(jsonlite)
library(lubridate)
library(dplyr)
library(ggplot2)
library(purrr)
library(fitdistrplus)


uiuc_weather_raw3 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4805&since=2016-03-01&until=2018-12-31")
uiuc_weather3 <- uiuc_weather_raw3$properties
"

system.time(
uiuc_time3 <- uiuc_weather_raw3 %>% 
  select(start_time, end_time) %>% 
  mutate(start = ymd_hms(start_time), end = ymd_hms(end_time)) %>% 
  rowwise() %>% 
  transmute(time = mean(c(start, end)))
)


uiuc_actual_times <- 
  map2_df(uiuc_time3$start_time, uiuc_time3$end_time, 
          (function (x,y) mean(c(ymd_hms(x),ymd_hms(y))))

uiuc_actual_times[[1]]

# The above is a POSIX time, as desired

uiuc_actual_times.df <- data.frame(unlist(uiuc_actual_times))

uiuc_actual_times.df[[1]]

# I would like to (and can) perform a bind_cols() operation with uiuc_actual_times.df now, but as you can see, the entries are not being recognized as POSIX values
