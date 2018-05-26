
#Functions that flag corrupted data depending on the variable. Depending on the instrument you can set up the lower and upper bound 



corrupt_humidity <- function (lower_bound, upper_bound){
  
  relhumidity <- uiuc_weather_raw2$properties$relative_humidity  #Set up the relative humidity variable you want to check
  
  for(i in 1:length(relhumidity)){
    if((relhumidity[i]<lower_bound)+(relhumidity[i]>upper_bound)){
      relhumidity[i]<- 1  #'FALSE'#add [i] here
    }
    else{
      relhumidity[i]<- 0 #'TRUE'#add [i] here
    }
  }
  
  plot(relhumidity, col='blue')  
}


corrupt_temperature<- function (lower_bound, upper_bound){
  
  airtemp <- uiuc_weather_raw2$properties$air_temperature  #Set up the relative humidity variable you want to check
  
  for(i in 1:length(airtemp)){
    if((airtemp[i]<lower_bound)+(airtemp[i]>upper_bound)){
      airtemp[i]<- 1  #'FALSE'#add [i] here
    }
    else{
      airtemp[i]<- 0 #'TRUE'#add [i] here
    }
  }
  
  plot(airtemp, col='red')  
}
