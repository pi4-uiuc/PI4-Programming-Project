library(lubridate)
library(dplyr)
library(ggplot2)
library(fitdistrplus)
require(gridExtra)

select <- dplyr::select

savePlot <- function(title, myPlot) {
  pdf(paste("data/",title,".pdf"))
  print(myPlot)
  dev.off()
}

all_weather <- read_csv("data/uiuc_met.csv")
uiuc_weather <- all_weather %>%
  collect %>%
  filter(grepl("UIUC", site))

# Plotting temperature from the three UIUC stations against each other on a common time-series graph

sites <- unique(all_weather$site)
uiuc_sites <- sites[sapply(sites, function(x) grepl("UIUC",x))]

weather_by_site <- list()
temp_plots <- list()
pressure_temp_plots <- list()


for (sitename in sites){
  weather_by_site[[sitename]] <- all_weather %>%
    filter(site == sitename) %>%
    select(time, temp = air_temperature, pressure = air_pressure, humidity = relative_humidity)
  temp_plots[[sitename]] <- ggplot(data = weather_by_site[[sitename]] %>% filter(!is.na(temp)), aes(x = time, y = temp, color = sitename)) + geom_line()    # Comparing pressure with air temperature and humidity in UIUC. By the barometric formula, with elevation held constant, these two ought to be correlated.
  savePlot(paste(sitename, " Temp Plot"), temp_plots[[sitename]])
}

savePlot("Individual UIUC Temp Plots", grid.arrange(grobs = temp_plots, ncols = 2))
savePlot("Overlayed May 2017 UIUC Temp Plots", ggplot(data = all_weather %>% filter(time >= ymd_hms("2017/09/01 00:00:00")) %>% filter(time < ymd_hms("2017/9/15 00:00:00")), aes(x = time, y = air_temperature, color = site)) + geom_line(alpha=0.6))

for (sitename in uiuc_sites){
  pressure_temp_plots[[sitename]] <- ggplot(data = weather_by_site[[sitename]], aes(x = time, y = (as.numeric(pressure))/temp, color = sitename)) + geom_line()    # Comparing pressure with air temperature and humidity in UIUC. By the barometric formula, with elevation held constant, these two ought to be correlated.
  savePlot(paste(sitename, " Pressure-Temp Plot"), pressure_temp_plots[[sitename]])
}

# It appears that pressure / temp is a crude, but not entirely arbitrary ratio to look at; the graph looks periodic, so maybe this predictor will become more accurate once time-of-day is also taken into account?

small_uiuc_weather <- uiuc_weather %>% filter(time >= ymd_hms("2017/09/01 00:00:00")) %>% filter(time < ymd_hms("2017/9/08 00:00:00"))

savePlot("Overlayed May 2017 UIUC Pressure-Temp Plot", ggplot(data = small_uiuc_weather, aes(x = time, y = as.numeric(air_pressure) / air_temperature, color = site)) + geom_line(alpha=0.6))

# As can be seen, there doesn't seem to a strong /direct/ relationship between temp and pressure; the following scatter plot is all over the place

savePlot("Pressure-Temp Scatter Plot", ggplot(data = small_uiuc_weather , aes(x = as.numeric(air_pressure), y = air_temperature)) + geom_jitter())

# Correlation matrix of the three pertinent variables, on a small dataset

cor(small_uiuc_weather %>% collect %>% transmute(as.numeric(air_pressure), as.numeric(air_temperature), as.numeric(relative_humidity)))
