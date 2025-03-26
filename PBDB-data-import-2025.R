#### Load in Phanerozoic PBDB data - this may take a few seconds (or as many as a couple of minutes!) ####

load(url("https://raw.githubusercontent.com/richardstockey/SOES1009/main/Practical_9-10_Phanerozoic_data.RData"))


#### View dataset ####

View(all_data)

#### Dataset filtering ####
# note that the data frame you have just loaded in is called all_data

new_dataset <- filter(xxx, xxx == xxx) # replace xxx with the appropriate column names and values


#### Dataset summarising ####

sum_pt1 <- new_dataset %>%
  group_by(stg, genus) %>% 
  tally() # how many occurrences are there of each genus in each stage?

sum <- sum_pt1 %>%
  group_by(stg) %>%
  tally() # how many genera are there of your chosen group in each stage?

#### Dataset plotting ####
ggplot(data = sum, aes(x = stg, y = n)) +
  geom_xxx()+ # replace xxx with an appropriate graph type
  theme_bw()+
  xlab("Stage Number")+
  ylab("Number of [xxx] Genera")+ # replace [xxx] with the appropriate taxon name§
  xlim(4, 95)


#### make stage lookup table ####
stage_table <- all_data %>%
  select(stg, stage) %>%
  distinct() 

# put stage_table ascending order of stg so that it is useful 
stage_table <- stage_table[order(stage_table$stg),]

# View stage_table
View(stage_table)