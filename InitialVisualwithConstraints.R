library(dplyr)
library(lubridate)
library(jsonlite)

uiuc_weather_raw1 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4806&since=2016-03-01&until=2018-12-31")

uiuc_weather1 <- uiuc_weather_raw1$properties

uiuc_weather_raw2 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4807&since=2016-03-01&until=2018-12-31")
uiuc_weather2 <- uiuc_weather_raw2$properties
  
uiuc_weather_raw3 <- fromJSON(txt = "https://terraref.ncsa.illinois.edu/clowder/api/geostreams/datapoints?key=Pb3AUSqnUw&stream_id=4808since=2016-03-01&until=2018-12-31")
uiuc_weather3 <- uiuc_weathe_raw3$properties

#DATA SET 1
attach(uiuc_weather_raw1)
attach(properties)

#plot(air_temperature, ylim=c(215,350))
#abline(a=233.15,b=0)

#Air temperature Plot
plot(air_temperature, ylim=c(100,350),main = "Air temperature through time", xlab = "Time", ylab= "Air Temperature (K)" , type= 'l', col= 'blue')
abline(a=193.15, b= 0, col='red')
abline(a=333.15 , b=0, col= 'green')

 #Relative humidity Plot
 plot(relative_humidity, ylim= c(0, 105), type = 'l', col='blue', main= "Percentage of relative humidity through time", xlab= "Time", ylab="Relative Humidity (%)")
 abline(a=0, b=0, col= 'red')
 abline(a=100, b=0, col='green')
 #abline(a=95.25, b=0, col= 'purple')
 
 
 #Pressure Plot
 plot(air_pressure, ylim= c(980, 1050), type = 'l', col='purple', main= "Air Pressure through time", xlab= "Time", ylab="Air Pressure (Pa)")
 
 
 
detach(properties)
 detach(uiuc_weather_raw1)
 #############################################################################################################################################
 
 
 #DATA SET 2 
 attach(uiuc_weather_raw2)
attach(properties)

 #Air temperature Plot
 plot(air_temperature, ylim=c(100,350),main = "Air temperature through time", xlab = "Time", ylab= "Air Temperature (K)" , type= 'l', col= 'blue')
 abline(a=193.15, b= 0, col='red')
 abline(a= 333.15, b=0, col= 'green')
 
 
 plot(relative_humidity, ylim= c(-105, 105), type = 'l', col='blue')
 abline(a=0, b=0, col= 'red')
 abline(a=100, b=0, col='green')
 
 #Relative humidity Plot
 plot(relative_humidity, ylim= c(-105, 105), type = 'l', col='blue', main= "Percentage of relative humidity through time", xlab= "Time", ylab="Relative Humidity (%)")
 abline(a=0, b=0, col= 'red')
 abline(a=100, b=0, col='green')
 #abline(a=95.25, b=0, col= 'purple')
 
 #zoom of relative humidity
 plot(relative_humidity, ylim= c( 98, 101), type = 'l', col='blue', main= "Percentage of relative humidity through time", xlab= "Time", ylab="Relative Humidity (%)")
 abline(a=0, b=0, col= 'red')
 abline(a=100, b=0, col='green')
 #abline(a=95.25, b=0, col= 'red')
 
 
 plot(relative_humidity, ylim= c( -100, 1), type = 'l', col='blue', main= "Percentage of relative humidity through time", xlab= "Time", ylab="Relative Humidity (%)")
 abline(a=0, b=0, col= 'red')
 abline(a=100, b=0, col='green')
 #abline(a=95.25, b=0, col= 'red')
 
 
 #Pressure Plot
 plot(air_pressure, ylim= c(980, 1050), type = 'l', col='purple', main= "Air Pressure through time", xlab= "Time", ylab="Air Pressure (Pa)")
 
 
 detach(properties)
 detach(uiuc_weather_raw2)
 
 #############################################################################################################################################
 #DATA SET 3
attach(uiuc_weather_raw3)
attach(properties)
 
 #Air temperature Plot
 plot(air_temperature, ylim=c(100,350),main = "Air temperature through time", xlab = "Time", ylab= "Air Temperature (K)" , type= 'l', col= 'blue')
 abline(a=193.15, b= 0, col='red')
 abline(a=333.15 , b=0, col= 'green')
 
 
 plot(relative_humidity, ylim= c(0, 105), type = 'l', col='blue')
 abline(a=0, b=0, col= 'red')
 abline(a=100, b=0, col='green')
 
 #Relative humidity Plot
 plot(relative_humidity, ylim= c(0, 105), type = 'l', col='blue', main= "Percentage of relative humidity through time", xlab= "Time", ylab="Relative Humidity (%)")
 abline(a=0, b=0, col= 'red')
 abline(a=100, b=0, col='green')
 #abline(a=95.25, b=0, col= 'purple')
 
 #zoom of relative humidity
 plot(relative_humidity, ylim= c(99, 101), type = 'l', col='blue', main= "Percentage of relative humidity through time", xlab= "Time", ylab="Relative Humidity (%)")
 abline(a=0, b=0, col= 'red')
 abline(a=100, b=0, col='green')
 # abline(a=95.25, b=0, col= 'red')
 
 #Pressure Plot
 plot(air_pressure, ylim= c(980, 1050), type = 'l', col='purple', main= "Air Pressure through time", xlab= "Time", ylab="Air Pressure (Pa)")
 
 
 detach(properties)
 detach(uiuc_weather_raw3)
 
 
 
