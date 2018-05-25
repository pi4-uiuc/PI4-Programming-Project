corrupt_temp <- function (air_temperature, lower_bound, upper_bound){
  if(air_temperature > lower_bound && air_temperature < upper_bound) {
    return(0)
  } else {return(1)}
}


corrupt_humidity <- function (relative_humidity, lower_bound, upper_bound){
  if(relative_humidity> lower_bound && air_temperature < upper_bound) {
    return(0)
  } else {return(1)}
}



corrupt_temps_uiuc2 <- (uiuc_weather_raw2$properties$air_temperature < 193.15) + (uiuc_weather_raw2$properties$air_temperature > 333.15)

corrupt_humidity_uiuc2 <- (uiuc_weather_raw2$properties$relative_humidity< 0) + (uiuc_weather_raw2$properties$relative_humidity > 100)





# corrupt_temps_uiuc2 <- uiuc_weather_raw2$properties$air_temperature %>% 
#   rowwise() %>% 
#   corrupt_temp(193.15,333.15)


# corrupt_temps_uiuc1 <- c()
# 
# for(i in 1:nrow(uiuc_weather_raw1)) {
#   corrupt_temps_uiuc1 <- c(corrupt_temps_uiuc1, corrupt_temp(uiuc_weather_raw1$properties$air_temperature[i], 193.15, 333.15))
# }
# 
# 
# corrupt_temps_uiuc2 <- c()
# 
# for(i in 1:nrow(uiuc_weather_raw2)) {
#   uiuc_weather_raw2$corrupt[i] <- corrupt_temp(uiuc_weather_raw1$properties$air_temperature[i], 193.15, 333.15)
#   
#   # corrupt_temps_uiuc2 <- c(corrupt_temps_uiuc2, corrupt_temp(uiuc_weather_raw1$properties$air_temperature[i], 193.15, 333.15))
# }
# 
# View(corrupt_temps_uiuc2)
