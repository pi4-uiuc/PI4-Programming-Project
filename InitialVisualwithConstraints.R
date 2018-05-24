library(dplyr)
library(lubridate)
library(jsonlite)

uiuc_weather_raw1 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4806&since=2016-03-01&until=2018-12-31")

uiuc_weather1 <- uiuc_weather_raw1$properties

uiuc_weather_raw2 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4805&since=2016-03-01&until=2018-12-31")
uiuc_weather2 <- uiuc_weather_raw2$properties


## This isn't the data station we're looking for; LeBauer told us there would be a third station that looks like the above, but this one must be incorrect; please fix
  
uiuc_weather_raw3 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4808&since=2016-03-01&until=2018-12-31")

attach(uiuc_weather_raw1)
attach(properties)

plot(air_temperature, ylim=c(215,350))
abline(a=233.15,b=0)

#Air temperature Plot
plot(air_temperature, ylim=c(215,350),main = "Air temperature through time", xlab = "Time", ylab= "Air Temperature (K)" , type= 'l', col= 'blue')
abline(a=233.15, b= 0, col='red')
 abline(a= 343.15, b=0, col= 'green')


plot(relative_humidity, ylim= c(0, 100), type = 'l', col='blue')
 abline(a=0, b=0, col= 'red')
 abline(a=95, b=0, col='green')

 #Relative humidity Plot
 plot(relative_humidity, ylim= c(0, 100), type = 'l', col='blue', main= "Percentage of relative humidity through time", xlab= "Time", ylab="Relative Humidity (%)")
 abline(a=0, b=0, col= 'red')
 abline(a=95, b=0, col='green')
 abline(a=95.25, b=0, col= 'purple')
 
 #zoom of relative humidity
 plot(relative_humidity, ylim= c(94, 99), type = 'l', col='blue', main= "Percentage of relative humidity through time", xlab= "Time", ylab="Relative Humidity (%)")
  abline(a=0, b=0, col= 'red')
 abline(a=95, b=0, col='green')
 abline(a=95.25, b=0, col= 'red')
 
 detach(uiuc_weather_raw1)
 attach(uiuc_weather_raw2)
 attach(properties)

 #Air temperature Plot
 plot(air_temperature, ylim=c(215,350),main = "Air temperature through time", xlab = "Time", ylab= "Air Temperature (K)" , type= 'l', col= 'blue')
 abline(a=233.15, b= 0, col='red')
 abline(a= 343.15, b=0, col= 'green')
 
 
 plot(relative_humidity, ylim= c(0, 100), type = 'l', col='blue')
 abline(a=0, b=0, col= 'red')
 abline(a=95, b=0, col='green')
 
 #Relative humidity Plot
 plot(relative_humidity, ylim= c(0, 100), type = 'l', col='blue', main= "Percentage of relative humidity through time", xlab= "Time", ylab="Relative Humidity (%)")
 abline(a=0, b=0, col= 'red')
 abline(a=95, b=0, col='green')
 abline(a=95.25, b=0, col= 'purple')
 
 #zoom of relative humidity
 plot(relative_humidity, ylim= c(94, 99), type = 'l', col='blue', main= "Percentage of relative humidity through time", xlab= "Time", ylab="Relative Humidity (%)")
 abline(a=0, b=0, col= 'red')
 abline(a=95, b=0, col='green')
 abline(a=95.25, b=0, col= 'red')
 
 
 
