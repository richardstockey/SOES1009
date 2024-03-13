devtools::install_github('richardstockey/PaleogeographR', force = TRUE)
install.packages('readr')
install.packages('ggplot2')
install.packages('dplyr')
install.packages('paleteer')

library(PaleogeographR)
library(ggplot2)
library(readr)
library(dplyr)
library(paletteer)

############################################################
#################### ACTIVITY 2 ############################
############################################################

####################### Fig. 4  ############################

# download PBDB data
global_ichthyosaur_pbdb_url <- "https://paleobiodb.org/data1.2/occs/list.csv?pgm=gplates,scotese,seton&show=class,plant,ecospace,coll,loc,paleoloc,lith,env,geo&base_name=Ichthyosauria"

global_ichthyosaur_pbdb_data <- read_csv(global_ichthyosaur_pbdb_url)

# Generate best estimate of occurence age by taking the mean of the minimum and maximum age step
# for each fossil occurence (i.e. each row of the dataframe)
global_ichthyosaur_pbdb_data$mid_ma <- rowMeans(cbind(global_ichthyosaur_pbdb_data$min_ma, global_ichthyosaur_pbdb_data$max_ma))

# Calculate median age of Ichthyosaur fossil occurences
median_ichthyosaur_age <- median(global_ichthyosaur_pbdb_data$mid_ma)

# Generate map data for timestep
ichthyosaur.map.data <- scotese.map.data.gg(median_ichthyosaur_age)

# plot map (just to see how it looks)
ggplot(data = ichthyosaur.map.data, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = depth))+
  geom_rect()+
  scale_fill_paletteer_c("grDevices::Earth", direction = -1)+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Topography (m)")

# generate a palaeogeographic map with the paleobiology database occurrences on it
# NOTE - we use paleolng2 and paleolat2 because they correspond to the same tectonic plate model as our map
# you can try other options but for our purposes it doesn't really matter (different people have just developed different plate models)
ggplot(data = ichthyosaur.map.data, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = depth))+
  geom_rect()+
  annotate(geom="point", x = global_ichthyosaur_pbdb_data$paleolng2, y = global_ichthyosaur_pbdb_data$paleolat2, colour = "darkred")+
  scale_fill_paletteer_c("grDevices::Earth", direction = -1)+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Topography (m)")

####################### Fig. 5  ############################

# download PBDB data
global_mammoth_pbdb_url <- "https://paleobiodb.org/data1.2/occs/list.csv?pgm=gplates,scotese,seton&show=class,plant,ecospace,coll,loc,paleoloc,lith,env,geo&base_name=mammuthus"

global_mammoth_pbdb_data <- read_csv(global_mammoth_pbdb_url)

# Generate best estimate of occurence age by taking the mean of the minimum and maximum age step
# for each fossil occurence (i.e. each row of the dataframe)
global_mammoth_pbdb_data$mid_ma <- rowMeans(cbind(global_mammoth_pbdb_data$min_ma, global_mammoth_pbdb_data$max_ma))

# Now, it is your turn to generate the map described in Activity 2....







####################### Fig. 6  ############################

# download PBDB data
global_lepidodendron_pbdb_url <- "https://paleobiodb.org/data1.2/occs/list.csv?pgm=gplates,scotese,seton&show=class,plant,ecospace,coll,loc,paleoloc,lith,env,geo&base_name=lepidodendron"

global_lepidodendron_pbdb_data <- read_csv(global_lepidodendron_pbdb_url)

# Generate best estimate of occurence age by taking the mean of the minimum and maximum age step
# for each fossil occurence (i.e. each row of the dataframe)
global_lepidodendron_pbdb_data$mid_ma <- rowMeans(cbind(global_lepidodendron_pbdb_data$min_ma, global_lepidodendron_pbdb_data$max_ma))

# Now, it is your turn to generate the map described in Activity 2....






############################################################
#################### ACTIVITY 3 ############################
############################################################

# Download Paleobiology Database data for the UK
UK_pbdb_url <- "https://paleobiodb.org/data1.2/occs/list.csv?cc=UK&pgm=gplates,scotese,seton&show=class,plant,ecospace,coll,loc,paleoloc,lith,env,geo"

UK_pbdb_data <- read_csv(UK_pbdb_url)

# Generate best estimate of occurence age by taking the mean of the minimum and maximum age step
# for each fossil occurence (i.e. each row of the dataframe)
UK_pbdb_data$mid_ma <- rowMeans(cbind(UK_pbdb_data$min_ma, UK_pbdb_data$max_ma))

# Now, it is your turn to generate the plot described in Activity 3...






## BELOW TO DELETE
# Plot palaeolatitude of uk fossil occurences through the Phanerozoic

ggplot(pbdb_data, aes(x = mid_ma, y = paleolat2))+
  geom_point()+
  theme_bw()+
  scale_x_reverse()+
  xlab("Age (Ma)")+
  ylab("Paleolatitude (°)")


ggplot(pbdb_data, aes(x = mid_ma, y = paleolat))+
  geom_point()+
  theme_bw()+
  scale_x_reverse()+
  xlab("Age (Ma)")+
  ylab("Paleolatitude (°)")
global_mammoth_pbdb_data

# Calculate median age of mammoth fossil occurences
median_mammoth_age <- median(global_mammoth_pbdb_data$mid_ma)

# Generate map data for timestep
mammoth.map.data <- scotese.map.data.gg(median_mammoth_age)

# plot map (just to see how it looks)
ggplot(data = mammoth.map.data, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = depth))+
  geom_rect()+
  scale_fill_paletteer_c("grDevices::Earth", direction = -1)+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Topography (m)")

# generate a palaeogeographic map with the paleobiology database occurrences on it
# NOTE - we use paleolng2 and paleolat2 because they correspond to the same tectonic plate model as our map
# you can try other options but for our purposes it doesn't really matter (different people have just developed different plate models)
ggplot(data = mammoth.map.data, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = depth))+
  geom_rect()+
  annotate(geom="point", x = global_mammoth_pbdb_data$paleolng2, y = global_mammoth_pbdb_data$paleolat2, colour = "darkred")+
  scale_fill_paletteer_c("grDevices::Earth", direction = -1)+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Topography (m)")

global_lepidodendron_pbdb_data

# Calculate median age of lepidodendron fossil occurences
median_lepidodendron_age <- median(global_lepidodendron_pbdb_data$mid_ma)

# Generate map data for timestep
lepidodendron.map.data <- scotese.map.data.gg(median_lepidodendron_age)

# plot map (just to see how it looks)
ggplot(data = lepidodendron.map.data, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = depth))+
  geom_rect()+
  scale_fill_paletteer_c("grDevices::Earth", direction = -1)+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Topography (m)")

# generate a palaeogeographic map with the paleobiology database occurrences on it
# NOTE - we use paleolng2 and paleolat2 because they correspond to the same tectonic plate model as our map
# you can try other options but for our purposes it doesn't really matter (different people have just developed different plate models)
ggplot(data = lepidodendron.map.data, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = depth))+
  geom_rect()+
  annotate(geom="point", x = global_lepidodendron_pbdb_data$paleolng2, y = global_lepidodendron_pbdb_data$paleolat2, colour = "darkred")+
  scale_fill_paletteer_c("grDevices::Earth", direction = -1)+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Topography (m)")

