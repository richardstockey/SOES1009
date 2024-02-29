# if you think you might be missing any packages (i.e. if you are using a different computer to last week),
# run install.packages.R and any other installation lines from other scripts from the module GitHub
#
library(ggplot2)
library(dplyr)
# Load the data for this practical
load("~/SOES1009/Practical-5-6-model-data.RData")

# this RData file contains the following R data frames:
Cretaceous_SST # Sea surface temperature in °C
Cretaceous_surfT # Surface air temperature (more specifically, air temp at 1.5m) in °C
Cretaceous_seaice # Sea ice thickness in m

Eocene_SST  # Sea surface temperature in °C
Eocene_surfT # Surface air temperature (more specifically, air temp at 1.5m) in °C
Eocene_seaice # Sea ice thickness in m

Pliocene_SST  # Sea surface temperature in °C
Pliocene_surfT # Surface air temperature (more specifically, air temp at 1.5m) in °C
Pliocene_seaice # Sea ice thickness in m

LGM_SST # Sea surface temperature in °C
LGM_surfT # Surface air temperature (more specifically, air temp at 1.5m) in °C
LGM_seaice # Sea ice thickness in m

Holocene_SST # Sea surface temperature in °C
Holocene_surfT # Surface air temperature (more specifically, air temp at 1.5m) in °C
Holocene_seaice # Sea ice thickness in m


# These can be viewed in the R Console by just running the names above. 
# Alternatively, they can be viewed using the View() function, e.g.:
View(Cretaceous_SST)

# or summarized using the summary() function, e.g.:
summary(Cretaceous_SST)

# *************************************************
# You will want to use the summary() function to set your scale bounds when generating your R plots
# *************************************************

# *************************************************
## We will now walk through a series of example maps for the Eocene
# *************************************************

## Example sea surface temperature map (Figure 2 panel)
ggplot(data = Eocene_SST, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = SST))+
  geom_rect()+
  scale_fill_viridis_c(option = "inferno", limits = c(0,40))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "SST (°C)")

## Example sea ice thickness map (Figure 3 panel)
ggplot(data = Eocene_seaice, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = sea_ice))+
  geom_rect()+
  scale_fill_viridis_c(option = "viridis", limits = c(0,5))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Surface Ice\nThickness (m)")

## Example surface air temperature map (Figure 4 panel)
ggplot(data = Eocene_surfT, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = surfT))+
  geom_rect()+
  scale_fill_viridis_c(option = "inferno", limits = c(-10,45))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Surface Air\nTemperature (°C)")



# *************************************************
# We will now work through how to generate a latitudinal summary of the data and plot it
# *************************************************

# Latitudinal summary of SST
Eocene_SST_sum <- Eocene_SST %>%
  group_by(lat.mid) %>%
  summarise(mean_SST = mean(SST, na.rm = TRUE), 
            median_SST = median(SST, na.rm = TRUE), 
            quartile1_SST = quantile(SST, c(0.25), na.rm = TRUE), 
            quartile3_SST = quantile(SST, c(0.75), na.rm = TRUE)
  )

ggplot(data = Eocene_SST_sum, aes(x = lat.mid, y = median_SST, ymin = quartile1_SST, ymax = quartile3_SST))+
  geom_errorbar()+
  geom_point()+
  theme_bw(20)+
  xlab("Latitude (°)")+
  ylab("Sea Surface Temperature (°C)")+
  xlim(c(-90,90))+
  ylim(c(-1,35))

# *************************************************
# The subsequent plots you will need to make yourself...
# Remember to save all of your code as you go!
# *************************************************




