### David's code below
# meteorological meta-data is here: 
# https://docs.terraref.org/user-manual/data-products/environmental-conditions#variable-names-and-units

library(jsonlite)
library(dplyr)
library(lubridate)

# can use parameters &since=2016-03-01&until=2018-12-31 to subset data

rawmet <- list()
#3211 is AZ

for(stream_id in c(46431, 4806, 4807, 4805)){
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

z <- bind_rows(rawmet)
readr::write_csv(z, path = 'data/uiuc_met.csv')

