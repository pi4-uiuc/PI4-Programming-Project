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

uiuc_weather <- read_csv("data/uiuc_met.csv") %>%
  collect %>%
  filter(grepl("UIUC", site))

# Plotting temperature from the three UIUC stations against each other on a common time-series graph

sites <- unique(uiuc_weather$site)
weather_by_site <- list()
temp_plots <- list()
prestemp_ratio_plots <- list()


for (sitename in sites){
  weather_by_site[[sitename]] <- uiuc_weather %>%
    filter(site == sitename) %>%
    select(time, temp = air_temperature, pressure = air_pressure, humidity = relative_humidity)
  temp_plots[[sitename]] <- ggplot(data = weather_by_site[[sitename]], aes(x = time, y = temp, color = sitename)) + geom_line()    # Comparing pressure with air temperature and humidity in UIUC. By the barometric formula, with elevation held constant, these two ought to be correlated.
  savePlot(paste(sitename, " Temp Plot"), temp_plots[[sitename]])
}

savePlot("Individual UIUC Temp Plots", grid.arrange(grobs = temp_plots, ncols = 2))
savePlot("Overlayed May 2017 UIUC Temp Plots", ggplot(data = uiuc_weather %>% filter(time >= ymd_hms("2017/09/01 00:00:00")) %>% filter(time < ymd_hms("2017/9/15 00:00:00")), aes(x = time, y = air_temperature, color = site)) + geom_line(alpha=0.6))

for (sitename in sites){
  temp_plots[[sitename]] <- ggplot(data = weather_by_site[[sitename]], aes(x = time, y = pressure/temp, color = sitename)) + geom_line()    # Comparing pressure with air temperature and humidity in UIUC. By the barometric formula, with elevation held constant, these two ought to be correlated.
  savePlot(paste(sitename, " Pressure-Temp Plot"), temp_plots[[sitename]])
}

# It appears that pressure / temp is a crude, but not entirely arbitrary ratio to look at; the graph looks periodic, so maybe this predictor will become more accurate once time-of-day is also taken into account?

savePlot("Overlayed May 2017 UIUC Pressure-Temp Plot", ggplot(data = uiuc_weather %>% filter(time >= ymd_hms("2017/09/01 00:00:00")) %>% filter(time < ymd_hms("2017/9/08 00:00:00")), aes(x = time, y = air_pressure / air_temperature, color = site)) + geom_line(alpha=0.6))

# As can be seen, there doesn't seem to a strong /direct/ relationship between temp and pressure; the following scatter plot is all over the place

ggplot(data = uiuc_barometric1, aes(x = pressure, y = temp)) + geom_jitter()

# Humidity seems to be doing its own thing, as evidenced by the correlation matrix

cor(uiuc_weather %>% select(air_pressure, air_temperature, relative_humidity))
