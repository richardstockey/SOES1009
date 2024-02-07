###### Install key packages ######
library(devtools)
install_github('richardstockey/paleogeographR', force = TRUE) # this is a package we have made for this exercise

###########################################################################
########################### Activity 4 ####################################
###########################################################################

##### This function from the paleogeographR package enables us to plot palaeogeographic maps
# the "age" variable corresponds to geologic age in millions of years
# the "age" variable corresponds to the number of levels in the scale bar
scotese.map.simple(age = 200, levels = 12)

# these can then be saved in the plots window the right of your screen in RStudio
# we will want to do this multiple times in order to build our panel plots

###########################################################################
########################### Activity 5 ####################################
###########################################################################
library(readr)
# Import a csv file containing the key data from Westerhold et al. 2020 Science from our GitHub repository. 
Cenozoic_O18 <- read_csv("~/SOES1009/Cenozoic-O18-Westerhold-S34.csv")

library(ggplot2)

ggplot(Cenozoic_O18, aes(x = age_ma, y = d18O_binned))+
  geom_point()+
  scale_x_reverse()+
  theme_bw()+
  xlab("Age (Ma)")+
  ylab(expression(delta^18*"O in benthic foraminifera (‰)"))

## by employing a simple calculation, we can begin to estimate global temperature from benthic d18O
## of foraminifera
## Nowadays, some more complex calculations including impacts of sea ice, etc are used to estimate global sea-surface 
## temperature from d18O values
## However, this relationship between isotopes and temperature has been established for many years, with simple 
## quadratic equations from the 1950s enabling us to still get a very strong sense of relative temperature changes through time
## e.g.  T = 16.5 - 4.3 * d18O + 0.14 * d18O^2 (Epstein et al. 1953) - see https://en.wikipedia.org/wiki/%CE%9418O

d18O <- Cenozoic_O18$d18O_binned
Cenozoic_O18$temperature <- xxx # enter in the equation here yourself to add a new column to the dataframe we have imported!

ggplot(Cenozoic_O18, aes(x = age_ma, y = temperature))+
  geom_point()+
  scale_x_reverse()+
  theme_bw()+
  xlab("Age (Ma)")+
  ylab("Temperature (°C)")

  
  