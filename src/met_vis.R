library(jsonlite)
library(lubridate)
library(dplyr)
library(ggplot2)
library(purrr)
library(fitdistrplus)

select <- dplyr::select

uiuc_weather_raw1 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4806&since=2016-03-01&until=2018-12-31")
uiuc_weather1 <- uiuc_weather_raw1$properties

uiuc_weather_raw2 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4807&since=2016-03-01&until=2018-12-31")
uiuc_weather2 <- uiuc_weather_raw2$properties

uiuc_weather_raw3 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4805&since=2016-03-01&until=2018-12-31")
uiuc_weather3 <- uiuc_weather_raw3$properties






# Useful preliminary for multiple visualizations: Extracting the time series for each site.

uiuc_time1 <- uiuc_weather_raw1 %>% 
  head(1000) %>%
  select(start_time, end_time) %>% 
  mutate(start = ymd_hms(start_time), end = ymd_hms(end_time)) %>%
  rowwise() %>% 
  transmute(meantime = mean(c(start,end)))
  
uiuc_time2 <- uiuc_weather_raw2 %>% 
  head(1000) %>%
  select(start_time, end_time) %>% 
  mutate(start = ymd_hms(start_time), end = ymd_hms(end_time)) %>%
  rowwise() %>% 
  transmute(meantime = mean(c(start,end)))

uiuc_time3 <- uiuc_weather_raw3 %>% 
  head(1000) %>%
  select(start_time, end_time) %>% 
  mutate(start = ymd_hms(start_time), end = ymd_hms(end_time)) %>%
  rowwise() %>% 
  transmute(meantime = mean(c(start,end)))

# Plotting temperature from the three UIUC stations against each other on a common time-series graph

uiuc_temp1 <- uiuc_weather1 %>%
  head(1000) %>%
  select(temp = air_temperature) %>%
  bind_cols(uiuc_time1)

uiuc_temp2 <- uiuc_weather2 %>%
  head(1000) %>%
  select(temp = air_temperature) %>%
  bind_cols(uiuc_time2)

uiuc_temp3 <- uiuc_weather3 %>%
  head(1000) %>%
  select(temp = air_temperature) %>%
  bind_cols(uiuc_time3)

uiuc_all_temps <- bind_rows(uiuc_temp1, uiuc_temp2, uiuc_temp3)

ggplot(data = uiuc_all_temps, aes(x = meantime, y = temp, color = site)) + geom_line()

# Comparing pressure with air temperature and humidity in UIUC. By the barometric formula, with elevation held constant, these two ought to be correlated.

uiuc_barometric1 <- uiuc_weather1 %>%
  head(1000) %>%
  select(temp = air_temperature, pressure = air_pressure, humidity = relative_humidity) %>%
  bind_cols(uiuc_time1)

# It appears that pressure / temp is a crude, but not entirely arbitrary ratio to look at; the graph looks periodic, so maybe this predictor will become more accurate once time-of-day is also taken into account?

ggplot(data = uiuc_barometric1, aes(x = meantime, y = pressure / temp)) + geom_line()
       
# As can be seen, there doesn't seem to a strong /direct/ relationship between temp and pressure; the following scatter plot is all over the place

ggplot(data = uiuc_barometric1, aes(x = pressure, y = temp)) + geom_jitter()

# Humidity seems to be doing its own thing, as evidenced by the correlation matrix

cor(uiuc_barometric1 %>% select(pressure, temp, humidity))



# l <- lm(pressure ~ temp + humidity + 1, data = uiuc_barometric1)
# plot(l)

