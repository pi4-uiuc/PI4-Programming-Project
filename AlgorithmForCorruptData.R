corrupt_temp <- function (air_temperature, lower_bound, upper_bound){
  for(i in 1:54632) {
  if(air_temperature > lower_bound && air_temperature < upper_bound) {
    return(FALSE)
  } else {return(TRUE)}
  }
}


