

library(PaleoClimR)

## Notes on which experiment to use for each interval... 
# Holocene - ~/Armstrong_2019/0 kyr teiia/teiia
# LGM - ~/Armstrong_2019/20 kyr teiiu/teiiu
# Pliocene - ~/Lunt_2010/Eociv - mid-Pliocene simulation tcofb/tcofb
# Early Eocene - ~/Valdes2021_HADCM3L/texpl1_055/texpl1_055
# Mid Cretaceous -  ~/Valdes2021_HADCM3L/texpv1_107/texpv1_107


# Eocene data extraction 
Eocene_SST <- HADCM3.data(var = "insitu_T_ym_dpth",
                          file = "o.pgclann",
                          experiment = "~/Valdes2021_HADCM3L/texpl1_055/texpl1_055", 
                          depth.level = 1,
                          dims = 3)

names(Eocene_SST)[7] <- "SST"

Eocene_SST <- filter(Eocene_SST, !(lon.mid < -177 | lon.mid > 177))

Eocene_surfT <- HADCM3.data(var = "temp_mm_1_5m",
                          file = "a.pdclann",
                          experiment = "~/Valdes2021_HADCM3L/texpl1_055/texpl1_055", 
                          depth.level = 1,
                          dims = 2)

Eocene_surfT$var <- Eocene_surfT$var - 273.15

names(Eocene_surfT)[7] <- "surfT"

Eocene_surfT <- filter(Eocene_surfT, !(lon.mid < -177 | lon.mid > 177))

Eocene_surfT <- filter(Eocene_surfT, !(lon.mid < -177 | lon.mid > 177))

Eocene_seaice <- HADCM3.data(var = "icedepth_mm_srf",
                            file = "a.pdclann",
                            experiment = "~/Valdes2021_HADCM3L/texpl1_055/texpl1_055", 
                            depth.level = 1,
                            dims = 2)

names(Eocene_seaice)[7] <- "sea_ice"

Eocene_seaice <- filter(Eocene_seaice, !(lon.mid < -177 | lon.mid > 177))

Eocene_seaice <- filter(Eocene_seaice, !(lon.mid < -177 | lon.mid > 177))

## Example sea surface temperature map (Figure 2)
ggplot(data = Eocene_SST, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = SST))+
  geom_rect()+
  scale_fill_viridis_c(option = "inferno", limits = c(0,40))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "SST (°C)")

## Example surface air temperature map (Figure 3)
ggplot(data = Eocene_surfT, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = surfT))+
  geom_rect()+
  scale_fill_viridis_c(option = "inferno", limits = c(-10,45))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Surface Air\nTemperature (°C)")

## Example sea ice thickness map (Figure 4)
ggplot(data = Eocene_seaice, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = sea_ice))+
  geom_rect()+
  scale_fill_viridis_c(option = "viridis", limits = c(0,5))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Surface Ice\nThickness (m)")

# Cretaceous data extraction
Cretaceous_SST <- HADCM3.data(var = "insitu_T_ym_dpth",
                          file = "o.pgclann",
                          experiment = "~/Valdes2021_HADCM3L/texpv1_107/texpv1_107", 
                          depth.level = 1,
                          dims = 3)

names(Cretaceous_SST)[7] <- "SST"

Cretaceous_SST <- filter(Cretaceous_SST, !(lon.mid < -177 | lon.mid > 177))

Cretaceous_surfT <- HADCM3.data(var = "temp_mm_1_5m",
                            file = "a.pdclann",
                            experiment = "~/Valdes2021_HADCM3L/texpv1_107/texpv1_107", 
                            depth.level = 1,
                            dims = 2)

Cretaceous_surfT$var <- Cretaceous_surfT$var - 273.15

names(Cretaceous_surfT)[7] <- "surfT"

Cretaceous_surfT <- filter(Cretaceous_surfT, !(lon.mid < -177 | lon.mid > 177))

Cretaceous_surfT <- filter(Cretaceous_surfT, !(lon.mid < -177 | lon.mid > 177))

Cretaceous_seaice <- HADCM3.data(var = "icedepth_mm_srf",
                             file = "a.pdclann",
                             experiment = "~/Valdes2021_HADCM3L/texpv1_107/texpv1_107", 
                             depth.level = 1,
                             dims = 2)

names(Cretaceous_seaice)[7] <- "sea_ice"

Cretaceous_seaice <- filter(Cretaceous_seaice, !(lon.mid < -177 | lon.mid > 177))

Cretaceous_seaice <- filter(Cretaceous_seaice, !(lon.mid < -177 | lon.mid > 177))

## Example sea surface temperature map (Figure 2)
ggplot(data = Cretaceous_SST, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = SST))+
  geom_rect()+
  scale_fill_viridis_c(option = "inferno", limits = c(0,40))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "SST (°C)")

## Example surface air temperature map (Figure 3)
ggplot(data = Cretaceous_surfT, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = surfT))+
  geom_rect()+
  scale_fill_viridis_c(option = "inferno", limits = c(-10,45))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Surface Air\nTemperature (°C)")

## Example sea ice thickness map (Figure 4)
ggplot(data = Cretaceous_seaice, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = sea_ice))+
  geom_rect()+
  scale_fill_viridis_c(option = "viridis", limits = c(0,5))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Surface Ice\nThickness (m)")


# Pliocene data extraction 
Pliocene_SST <- HADCM3.data(var = "insitu_T_ym_dpth",
                          file = "o.pgclann",
                          experiment = "~/Lunt_2010/Eociv - mid-Pliocene simulation tcofb/tcofb", 
                          depth.level = 1,
                          dims = 3)

names(Pliocene_SST)[7] <- "SST"

Pliocene_SST <- filter(Pliocene_SST, !(lon.mid < -177 | lon.mid > 177))

Pliocene_surfT <- HADCM3.data(var = "temp_mm_1_5m",
                            file = "a.pdclann",
                            experiment = "~/Lunt_2010/Eociv - mid-Pliocene simulation tcofb/tcofb", 
                            depth.level = 1,
                            dims = 2)

Pliocene_surfT$var <- Pliocene_surfT$var - 273.15

names(Pliocene_surfT)[7] <- "surfT"

Pliocene_surfT <- filter(Pliocene_surfT, !(lon.mid < -177 | lon.mid > 177))

Pliocene_surfT <- filter(Pliocene_surfT, !(lon.mid < -177 | lon.mid > 177))

Pliocene_seaice <- HADCM3.data(var = "icedepth_mm_srf",
                             file = "a.pdclann",
                             experiment = "~/Lunt_2010/Eociv - mid-Pliocene simulation tcofb/tcofb", 
                             depth.level = 1,
                             dims = 2)

names(Pliocene_seaice)[7] <- "sea_ice"

Pliocene_seaice <- filter(Pliocene_seaice, !(lon.mid < -177 | lon.mid > 177))

Pliocene_seaice <- filter(Pliocene_seaice, !(lon.mid < -177 | lon.mid > 177))

## Example sea surface temperature map (Figure 2)
ggplot(data = Pliocene_SST, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = SST))+
  geom_rect()+
  scale_fill_viridis_c(option = "inferno", limits = c(0,40))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "SST (°C)")

## Example surface air temperature map (Figure 3)
ggplot(data = Pliocene_surfT, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = surfT))+
  geom_rect()+
  scale_fill_viridis_c(option = "inferno", limits = c(-10,45))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Surface Air\nTemperature (°C)")

## Example sea ice thickness map (Figure 4)
ggplot(data = Pliocene_seaice, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = sea_ice))+
  geom_rect()+
  scale_fill_viridis_c(option = "viridis", limits = c(0,5))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Surface Ice\nThickness (m)")

# LGM data extraction 
LGM_SST <- HADCM3.data(var = "insitu_T_ym_dpth",
                          file = "o.pgclann",
                          experiment = "~/Armstrong_2019/20 kyr teiiu/teiiu", 
                          depth.level = 1,
                          dims = 3)

names(LGM_SST)[7] <- "SST"

LGM_SST <- filter(LGM_SST, !(lon.mid < -177 | lon.mid > 177))

LGM_surfT <- HADCM3.data(var = "temp_mm_1_5m",
                            file = "a.pdclann",
                            experiment = "~/Armstrong_2019/20 kyr teiiu/teiiu", 
                            depth.level = 1,
                            dims = 2)

LGM_surfT$var <- LGM_surfT$var - 273.15

names(LGM_surfT)[7] <- "surfT"

LGM_surfT <- filter(LGM_surfT, !(lon.mid < -177 | lon.mid > 177))

LGM_surfT <- filter(LGM_surfT, !(lon.mid < -177 | lon.mid > 177))

LGM_seaice <- HADCM3.data(var = "icedepth_mm_srf",
                             file = "a.pdclann",
                             experiment = "~/Armstrong_2019/20 kyr teiiu/teiiu", 
                             depth.level = 1,
                             dims = 2)

names(LGM_seaice)[7] <- "sea_ice"

LGM_seaice <- filter(LGM_seaice, !(lon.mid < -177 | lon.mid > 177))

LGM_seaice <- filter(LGM_seaice, !(lon.mid < -177 | lon.mid > 177))

## Example sea surface temperature map (Figure 2)
ggplot(data = LGM_SST, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = SST))+
  geom_rect()+
  scale_fill_viridis_c(option = "inferno", limits = c(-10,40))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "SST (°C)")

## Example surface air temperature map (Figure 3)
ggplot(data = LGM_surfT, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = surfT))+
  geom_rect()+
  scale_fill_viridis_c(option = "inferno", limits = c(-50,45))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Surface Air\nTemperature (°C)")

## Example sea ice thickness map (Figure 4)
ggplot(data = LGM_seaice, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = sea_ice))+
  geom_rect()+
  scale_fill_viridis_c(option = "viridis", limits = c(0,10))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Surface Ice\nThickness (m)")



# Holocene data extraction 
Holocene_SST <- HADCM3.data(var = "insitu_T_ym_dpth",
                          file = "o.pgclann",
                          experiment = "~/Armstrong_2019/0 kyr teiia/teiia", 
                          depth.level = 1,
                          dims = 3)

names(Holocene_SST)[7] <- "SST"

Holocene_SST <- filter(Holocene_SST, !(lon.mid < -177 | lon.mid > 177))

Holocene_surfT <- HADCM3.data(var = "temp_mm_1_5m",
                            file = "a.pdclann",
                            experiment = "~/Armstrong_2019/0 kyr teiia/teiia", 
                            depth.level = 1,
                            dims = 2)

Holocene_surfT$var <- Holocene_surfT$var - 273.15

names(Holocene_surfT)[7] <- "surfT"

Holocene_surfT <- filter(Holocene_surfT, !(lon.mid < -177 | lon.mid > 177))

Holocene_surfT <- filter(Holocene_surfT, !(lon.mid < -177 | lon.mid > 177))

Holocene_seaice <- HADCM3.data(var = "icedepth_mm_srf",
                             file = "a.pdclann",
                             experiment = "~/Armstrong_2019/0 kyr teiia/teiia", 
                             depth.level = 1,
                             dims = 2)

names(Holocene_seaice)[7] <- "sea_ice"

Holocene_seaice <- filter(Holocene_seaice, !(lon.mid < -177 | lon.mid > 177))

Holocene_seaice <- filter(Holocene_seaice, !(lon.mid < -177 | lon.mid > 177))

## Example sea surface temperature map (Figure 2)
ggplot(data = Holocene_SST, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = SST))+
  geom_rect()+
  scale_fill_viridis_c(option = "inferno", limits = c(-10,40))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "SST (°C)")

## Example surface air temperature map (Figure 3)
ggplot(data = Holocene_surfT, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = surfT))+
  geom_rect()+
  scale_fill_viridis_c(option = "inferno", limits = c(-10,45))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Surface Air\nTemperature (°C)")

## Example sea ice thickness map (Figure 4)
ggplot(data = Holocene_seaice, aes(xmin = lon.min, xmax = lon.max, ymin = lat.min, ymax = lat.max, fill = sea_ice))+
  geom_rect()+
  scale_fill_viridis_c(option = "viridis", limits = c(0,5))+
  coord_cartesian(expand = FALSE)+
  theme_bw(20)+
  xlab("Longitude (°)")+
  ylab("Latitude (°)")+
  labs(fill = "Surface Ice\nThickness (m)")


#### SAVE all of the data ####

save(file = "~/SOES1009/Practical-5-6-model-data.RData", 
     Cretaceous_seaice, 
     Cretaceous_SST, 
     Cretaceous_surfT, 
     Eocene_seaice, 
     Eocene_SST, 
     Eocene_surfT, 
     Pliocene_seaice, 
     Pliocene_SST, 
     Pliocene_surfT, 
     LGM_seaice, 
     LGM_SST, 
     LGM_surfT, 
     Holocene_seaice, 
     Holocene_SST, 
     Holocene_surfT
     )
















## Generate latitudinal summary

Eocene_SST_sum <- Eocene_SST %>%
  group_by(lat.min) %>%
  summarise(mean_SST = mean(SST, na.rm = TRUE), 
            median_SST = median(SST, na.rm = TRUE), 
            quartile1_SST = quantile(SST, c(0.25), na.rm = TRUE), 
            quartile3_SST = quantile(SST, c(0.75), na.rm = TRUE)
            )










