#SOES 1009 - Practicals 8/9: Biodiversity curves and mass extinctions

#load your Practical_9-10_Phanerozoic_data.RData:
#==== FILL IN HERE ====#

#load the functions
source('Prac_9-10_functions.R')

#========================================================================#
#           ACTIVITY 1 - GENERATING BIODIVERSITY CURVES  
#========================================================================#

#====================================#
#==== PART 1 - Counting Fossils =====#
#====================================#

#Here you will generate a basic biodiversity curve simply by counting the number of genera in each period for the following taxonomic groups:
#1. Trilobites
#2. Brachiopods
#3. Bivalves
#4. Cephalopods
#5. Gastropods
#6. Jawed fish (Chondrichthyes + Osteichthyes)

#Step 1: First, you need to break your data up into the different taxonomic groups using the subset() function. 
#Let's see what phyla are represented in our data
table(all_data$phylum) #This will show you which phyla are present in the dataset, and how many fossils belong to each phyla 

#Let's find our trilobites. First, we know that trilobites beling to the phylum Arthropoda, so let's isolate that data.
arthropod_data <- subset(all_data, phylum=='Arthropoda')
#The subset function works like this: subset(dataset, column_name=='What You're Looking For') 
#Or, if you are looking for more than one thing, you can do: subset(dataset, column_name %in% c('Thing 1', 'Thing 2', 'Thing 3'))
#IMPORTANT: We are using the double equal sign here, == , which is asking for logical information (true or false). A single equal sign = tells R to make two things equal just like <-, but it's not what we're after here.
?subset #take a look at the R Documentation for this function. This is good practice if you are using any new functions for the first time! 

#ultimately we are looking for class Trilobita, so let's check if that's in our Arthropoda dataset
table(arthropod_data$class) #This should show you that there are about ~30k trilobites. Let's pull them out.

trilobite_data <- subset(arthropod_data, class=='Trilobita')
#or this can just look like:
trilobite_data <- subset(all_data, class=='Trilobita') #you'll get the same thing either way, because all trilobites are in phylum Arthropoda. You can break the subsetting down into smaller or larger steps, depending on what you find easiest.
table(trilobite_data$class) #check to make sure we've subset just data in the class Trilobite

#Using your knowledge of the taxonomic classification for the remaining five groups, use subset to create individual datasets for each group. 
#HINT: They will not all be the same taxonomic levels, and you may have to use %in% to combine groups (see line 25)
#Brachiopods:
brachiopod_data <-  #=== FILL IN HERE ====#

#Bivalves:
bivalve_data <-  #=== FILL IN HERE ====#

#Cephalopods:
cephalopod_data <-  #=== FILL IN HERE ====#

#Gastropods:
gastropod_data <-  #=== FILL IN HERE ====#

#Jawed fish (Osteichthyes + Chondrichthyes) 
fish_data <-  #=== FILL IN HERE ====#

#You should now have six dataframes subset into our different taxonomic groups. It's good practice to open these datasets and make sure there is actually data in them! A few ways to do this:
class(arthropod_data) #first, make sure you have created a dataframe object (the class() function tells you what type of object something is; dataframe, logical, numeric, character, etc.)
head(arthropod_data) #this will give you the top of the dataframe in your console 
View(arthropod_data) #this will open up the entire dataframe in a new tab 
dim(arthropod_data) #you can also just check the size of the dataframe (the dim() function returns the dimensions of the object, in this case the number of rows and then the number of columns)

#Step 2: Set up your outputs
#PBDB data can get a little messy! Before beginning any analyses, we want to set up a dataframe to save our results.
#We want to create an empty dataframe with as many rows as their are stages in the Phanerozoic, and as many columns as we have taxonomic groups.

#We can use our divDyn package that we loaded in early to get all of our Phanerozoic stages:
library(divDyn)
data(stages) #this loads the stages dataframe from the package
View(stages) #check it out! we want all of the stages from the Cambrian to the Holocene
phanerozoic_stages <- stages$stage[4:95]

#And we also want a list of our taxonomic groups 
groups <- c('trilobites', 'brachiopods', 'bivalves', 'cephalopods', 'gastropods', 'fish')

#For example, if I just wanted to set up a dataframe for my trilobites, I would do this
example_df <- as.data.frame(matrix(data=NA, 
                                   nrow=length(phanerozoic_stages),
                                   ncol=length(c('trilobites'))
                                   ))
rownames(example_df) <- phanerozoic_stages #name our rows for each stage
colnames(example_df) <- 'trilobites' #and name our columns for the group 
View(example_df) #let's see how that looks
#SPOILER ALERT: This is a neat way of setting up your outputs, because if you want to know how many trilobites there are in a particular stage, you can easily call that data:
example_df['Hirnantian', 'trilobites'] #This will return an NA because we haven't filled the results yet, but we can actually use this to fill in our table later on!

#Now let's set up your empty dataframe. There are lots of ways to do this, but let's convert a matrix into a dataframe:
part1_results <- as.data.frame(matrix(data=NA, #make the dataframe empty
                                       nrow=, #make the number or rows the length of phanerozoic_stages #=== FILL IN HERE ====#
                                       ncol=  #make the number of columsnt he length of your taxonomic groups  #=== FILL IN HERE ====#
                                       ))
rownames(part1_results) <-  #Make your row names your Phanerozoic stages #=== FILL IN HERE ====#
colnames(part1_results) <-  #Make your column names your taxonomic groups #=== FILL IN HERE ====#
View(part1_results) #So if you open this up, you should have a dataframe of NAs with 92 rows, each with a Phanerozoic stage name, and 6 columns, each with a name for your taxonomic groups 

#Step 3: Counting generic richness
#The simplest diversity metric we use in the fossil record is generic richness, or the number of unique genera in a given interval or place
#For example, let's say I want to get generic richness of trilobites during the Hirnantian
hirnantian_trilobites <- subset(trilobite_data, stage=='Hirnantian') #First we would subset the data just for the Hirnantian stage
unique(hirnantian_trilobites$genus) #check out the genera that are in the Hirnantian. We want to count these.
hirnantian_trilobite_richness <- length(unique(hirnantian_trilobites$genus)) #and this will use length() to count the number of unique (with unique()) genera of trilobites of the Hirnantian
hirnantian_trilobite_richness #this is our generic richness for trilobites in the Hirnantian

#And then we can save that easily in our results
example_df['Hirnantian', 'trilobites'] <- hirnantian_trilobite_richness


#Easy, right? Because we're going to measure richness many, many, many times, let's set up a function:
get_richness <- function(taxonomic_data, your_stage){ #this means that our function will look like get_richness() and the first input will be your taxonomic group dataframe and the second input will be the stage that you want generic richness for
  
  this.stage.data <- subset(taxonomic_data, stage==your_stage) #get the data for the stage we want. This corresponds to line 98
  this.stage.richness <-   #calculate generic richness of this.stage.data (hint -- see line 100!) #=== FILL IN HERE ====#
    
  #return(this.stage.data)
  return(this.stage.richness) #this actually saves and returns that result
  
}
#To save this function, run lines 107-114 in your command line
#In your R Environment, you should now see get_richness in the Functions section

#Let's check that worked with our Hirnantian trilobites 
test.function <- get_richness(trilobite_data, 'Hirnantian')
test.function #this should be the same value as hirnantian_trilobite_richness

#And we can even simplify our code to save this directly into our dataframe
example_df['Hirnantian', 'trilobites'] <- get_richness(trilobite_data, 'Hirnantian')
example_df['Hirnantian', 'trilobites'] #et voila! 

#So we could do this 92 times for each Phanerozoic stage, and then 6 times for each taxonomic group. But that sounds tedious, right? Let's work smarter, not harder.
#We can use a for loop to make this extra easy for us.

get_phanerozoic_richness <- function(taxonomic_data, your_stages){
  
  richness_per_stage <- rep(NA, length(your_stages)) #this is a blank vector we've created to store our data.
  #Note that is the same length as the input your_stages 
  #Each place (i) in the vector corresponds directly to the ith place in your_stages (which in our case is phanerozoic_stages)
  #In other words, the 1st place in richness_per_stage[i=1] corresponds to the 1st place in phanerozoic_stages[i=1], which is a Cambrian stage called the Fortunian 
  #And richness_per_stage[i=49] corresponds to phanerozoic_stages[i=49], which is a Triassic stage called the Induan 
  
  #We are going to use a for loop here, which gets R to do the work of calculating generic richness over and over again for our 92 different stages:
  for(i in 1:  ){ #what to we put after 1: to make our for loop go through each stage (your_stages)? #=== FILL IN HERE ====#
    
    this.stage <- your_stages[i] #what stage are we in? phanerozoic_stages[i]
    
    #Now, use your get_richness function to calculate generic richness
    this.stage.richness <-  #=== FILL IN HERE ====#
    
    richness_per_stage[i] <- this.stage.richness #and save that in our vector that we created to store our data
    
  }
  
  return(richness_per_stage) #gives us our results back 
  
}

#and now we can actually use this to calculate generic richness in each stage
#for example, for trilobites:
example_df$trilobites <- get_phanerozoic_richness(trilobite_data, phanerozoic_stages)
View(example_df)

#Just to explore this function, what happens when we only use the first ten stages in phanerozoic_stages?
first_ten <- phanerozoic_stages[1:10]
get_phanerozoic_richness(trilobite_data, first_ten)
#which stages do each of those outputs correspond to? 

#Using that as an example, calculate richness in each stage using get_phanerozoic_richness and save it to part1_results:
#Trilobites
part1_results$trilobites <-  #=== FILL IN HERE ====#

#Brachiopods
part1_results$brachiopods <-  #=== FILL IN HERE ====#

#Bivalves
part1_results$bivalves <-  #=== FILL IN HERE ====#

#Cephalopods
part1_results$cephalopods <- #=== FILL IN HERE ====#

#Gastropods
part1_results$gastropods <- #=== FILL IN HERE ====#

#Fish
part1_results$fish <-  #=== FILL IN HERE ====#

#Let's see what that looks like
View(part1_results)

#Finally, add stage midpoints so we can actually plot this with millions of years on the x axis.
part1_results$mid_ma <- stages$mid[4:95]

#==== Plot your results for Activity 1 - Part 1 ====# 
#See handout for guidance for plotting the results that you have saved in part1_results 




#====================================#
#==== PART 2 - Sampling Biases  =====#
#====================================#
#Here you will assess how biased your results are from differences in sampling effort (or the amount of research effort dedicated to different time periods and places on Earth)

#In the PBDB, a collection represents a group of fossils collected from the same place at the same time (for example, all fossils reported in the same paper)
#Each fossil occurrence is tagged with a collection number in the collection_no column. We can look at the collections here:
table(all_data$collection_no) #not a lot to look at, but you can there are a lot of collection numbers!

#We can explore a specific collection. Lets look at collection #1834:
collection_1834 <- subset(all_data, collection_no==1834)
View(collection_1834) 
#Note that all of these fossil occurrences are the same age (stage) and from same place (lat and lng)

#We can also check how many total collections are in the PBDB dataset:
length(unique(all_data$collection_no)) 
#You can also try that out in your different taxonomic groups
length(unique(trilobite_data$collection_no))
#that's a lot of sampling effort! is it evenly distributed throughout time and space?

#=== Step 1 - Temporal sampling biases ===#
#Let's investigate how many collections there are per time in each of our six taxonomic groups
#Again, before beginning any analyses, we want to set up a way to save our results:

part2_temporal_results <- as.data.frame(matrix(data=NA,
                                               nrow=,  #each row is a stage #==== FILL IN HERE ====# 
                                               ncol=
                                                 )) #and each column is a taxonomic group #==== FILL IN HERE ====#
rownames(part2_temporal_results) <-  #make row names your phanerozoic stages #==== FILL IN HERE ====#
colnames(part2_temporal_results) <-  #make column names your taxonomic group names #==== FILL IN HERE ====#
View(part2_temporal_results) #make sure that looks how you want it to. HINT - It should resemble part1_results

#Similar to our function to calculate richness, we are going to make a function to count the number of collections in each stage:
count_collections <- function(taxonomic_data, your_stage){
  
  this.stage.data <-  #how do you subset this data to just select the stage that you input in your_stage? #=== FILL IN HERE ====#
  n.collections <- length(unique(this.stage.data$``)) #what column do you need to call to count the number of collections? #=== FILL IN HERE ===#
  return(n.collections) #return the data to us 
  
}

#Run the lines of code to build that function, and check it is in your environment under Functions along with get_richness and get_phanerozoic_richness
#So now we can use that function to get the number of collections 
#For example, let's look at how many collections contain trilobites in the Hirnantian
hirnantian_trilobite_collections <- count_collections(trilobite_data, 'Hirnantian')
hirnantian_trilobite_collections

#and remember, we could save that to our results dataframe as so:
part2_temporal_results['Hirnantian', 'trilobites'] <- count_collections(trilobite_data, 'Hirnantian')
part2_temporal_results['Hirnantian', 'trilobites']

#Just like when we calculated generic richness, we could do this 92 times for every single taxonomic group, but we can make R do the hard work for us with a for loop:
get_phanerozoic_collections <- function(taxonomic_data, your_stages){
  
  #This is all going to look just like our get_phanerozoic_richness function, except we want to count collections instead of genera
  
  collections_per_stage <- rep(NA, length(your_stages)) #let's set up an empty vector to save our results that we get using our for loop
  
  for(i in 1:length(your_stages)){ #again, we want to set the loop to run for every stages 
    
    this.stage <- your_stages[i] #at the start of each loop iteration, we select the correct stage
   
    #Now, use your count_collections function to calculate generic richness
    #HINT: Remember what your two inputs are for your count_collections() function.
    this.stage.richness <-  #=== FILL IN HERE ====#
    
    collections_per_stage[i] <- this.stage.richness #and then we want to save that in the blank vector we set up
    
  }
  
  return(collections_per_stage) #return our output of number of collections in each stage 
  
}

#Run those lines to save your function, and let's test that out
trilobite_collections <- get_phanerozoic_collections(trilobite_data, phanerozoic_stages)
trilobite_collections

#And again to explore this function, what happens when we only use the 20th-25th stages in the phanerozoic?
some_stages <- phanerozoic_stages[20:25]
get_phanerozoic_collections(trilobite_data, some_stages)
#which stages do each of those outputs correspond to? (Hint: what stages are some_stages?)

#Using that as an example, calculate richness in each stage using get_phanerozoic_richness and save it to part1_results:
#Trilobites
part2_temporal_results$trilobites <- #=== FILL IN HERE ====#

#Brachiopods
part2_temporal_results$brachiopods <-  #=== FILL IN HERE ====#

#Bivalves
part2_temporal_results$bivalves <-  #=== FILL IN HERE ====#

#Cephalopods
part2_temporal_results$cephalopods <-  #=== FILL IN HERE ====#

#Gastropods
part2_temporal_results$gastropods <-  #=== FILL IN HERE ====#

#Fish
part2_temporal_results$fish <- #=== FILL IN HERE ====#

#Let's see what that looks like
View(part2_temporal_results)

#Finally, add stage midpoints so we can actually plot this with millions of years on the x axis.
part2_temporal_results$mid_ma <- stages$mid[4:95]

#==== Plot your results for Activity 1 - Part 2, Temporal Biases ====# 
#See handout for guidance for plotting the results that you have saved in part2_results 

#HINT - An easy and fast (but admittedly clunky) way to use ggplot to plot data from your two different dataframes 
ggplot(part2_temporal_results) +
  geom_point(aes(x=trilobites, y=part1_results$trilobites)) +
  geom_smooth(aes(x=trilobites, y=part1_results$trilobites), method='lm')
#You can use this as a guide if you would like, but see the actual guidance in your handout on what needs to be in your Figure 2 












#=== Step 2 - Spatial biases ===#
#To explore spatial biases, we are going to construct rarefaction curves for different continents
#Note that from now on we are not using the taxonomic datasets 
#Rarefaction curves estimate the expected number of genera present given different levels of sampling effort. In our case, this sampling effort is the number of collections sampled

#PBDB data is partitioned into continents. You can view that here
table(all_data$continent)

#Using subset(), create separate datasets for each continent
africa_data <-  #==== FILL IN HERE ====#
asia_data <-  #==== FILL IN HERE ====#
europe_data <-  #==== FILL IN HERE ====#
northamerica_data <-  #==== FILL IN HERE ====#
southamerica_data <-  #==== FILL IN HERE ====# 

#If you haven't already,  make sure you have loaded the functions in Prac_9-10_functions.R
source('Prac_9-10_functions.R')
#you should have a do_rarefaction function

#We are going to generate rarefaction curves for the Induan stage
#Open up view(stages) and look for the Induan -- see what mass extinction it precedes?
#Palaeontologists are particularly interested in the Induan because it is our record of how severe the end-Permian mass extinction was, which is a key time interval to study if we want to understand how rapid global warming impacts the biosphere 
#So, it's important to see how spatial biases impact our data so that our interpretation of changes in biodiversity are robust

#In our rarefaction curves, we are going to progressively sample an increasing number of collections until we reach that actual number of collections in the PBDB for that continent
#How do we interpret our rarefaction curves?
      #if the curve has flat-lined, we have reached a "true" measure of biodiversity that is not biased by sampling effort
      #if the curve is still increasing by the time we reach our actual number of collections, our richness results are likely impacted by sampling biases

#First - let's find how many PBDB collections are in each stage on each continent. We can use our count_collections() function
#Hint 1 - instead of taxonomic data, what subsetted datasets are we interested in?
max.africa.collections <-  #==== FILL IN HERE ====#
max.asia.collections <-  #==== FILL IN HERE ====#
max.europe.collections <-  #==== FILL IN HERE ====#
max.northamerica.collections <-  #==== FILL IN HERE ====#
max.southamerica.collections <-  #==== FILL IN HERE ====#

#Let's call those to see how many collections are on each continent in the Induan
max.africa.collections
max.asia.collections
max.europe.collections
max.northamerica.collections
max.southamerica.collections

#Note the uneven distribution of data here. Make note of which continents do not have any data at all! 

#Now let's use our do_rarefaction function to generate rarefaction curves.
#do_rarefaction takes three inputs:
#the first is your continent dataset
#the second is your time period, as character (similar to what you did with count_collections)
#and the third is the maximum number of collections we can sample, which is equal to the each continent's total number collections

#Now use do_rarefaction to generate the curves. Note what happens when you try to use do_rarefaction on the continents where you lack any data!
africa_rarefaction <-  #==== FILL IN HERE ====#
asia_rarefaction <- #==== FILL IN HERE ====#
europe_rarefaction <-  #==== FILL IN HERE ====#
northamerica_rarefaction <-   #==== FILL IN HERE ====#
southamerica_rarefaction <-   #==== FILL IN HERE ====#

#==== Plot your results for Activity 1 - Part 2, Temporal Biases ====# 
#See handout for guidance for plotting the rarefaction curves
#Note that you have outputs for richness and a column called 'sd'
#sd is the standard deviation on your generic richness estimate. You should use this to plot uncertaintly as richness +- 1 standard deviation.

#This is an exmaple of how to use geom_ribbon to plot uncertainty on a line graph
example.data <- data.frame(x=1:100,
                           y=(0.02*(1:100)^2+rnorm(100, mean = 0, sd = 10)), #just generating random data for you here 
                           sd=rnorm(100, mean=10, sd=1))
ggplot(example.data) +
  geom_ribbon(aes(x=x,
                  ymin=y-sd, #lower uncertainty is your value for the y axis minus 1 standard deviation
                  ymax=y+sd, #upper uncertaintly is your value for the y axis plus 1 standard deviation
                  ), fill='gray') + #make the ribbon gray so you can distinguish between error and line 
  geom_line(aes(x=x,y=y)) +
  theme_bw() 










#==================================================#
#==== PART 3 - The "real" biodiversity curves =====#
#==================================================#
#We are now going to return to your taxonomic datasets to generate subsampled generic richness curves
#If you need to get the functions, run:
source('Prac_9-10_functions.R')
#You should have a function called subsample_fossils, which is what we're going to use to generate our final diversity curves
#This function works by "evening out" the number of collections sampled in each time bin

#Let's return to your Part 2 Step 1 results:
View(part2_temporal_results)

#Let's also make figures to visualize the number of collections in each stage for each taxonomic group:
#==== FILL IN HERE ====#





#As you should see, in no taxonomic group do we have an even number of samples in each stage.

#Before use subsampling to construct a richness curve, we need to decide what our "collections quota" is.
#Your collections quota refers to the number of collections that you are going to randomly sample in each stage.
#There is no clear rule for this! Today, you should use your part2_temporal_results to find a collections quota that 
#         1) is small enough that most of your stages have more collections than your quota
#         2) but is also large enough that you can actually get a reasonable estimate of biodiversity.
#Note that you will not be able to calculate subsampled richness in stages that have fewer collections than your collection quota. You will inevitably, therefor, have some blanks. This is okay! Selecting your quota is about striking a balance.
#Stages with insufficient data for subsampling will have a raw generic richness output and will be marked 'raw' in the 'output_type' column

#Because this is subjective, make Table 1 (see handout) picking and justifying your quotas for each group. When selecting your quotas, it may be useful to plot them as horizontal lines on the figures you have made above to see how many stages fall above your quota.
#Once you have created and filled out Table 1, assign your quotas to the following variables:

trilobite.collections.quota <-  #==== FILL IN HERE ====#
brachiopod.collections.quota <-  #==== FILL IN HERE ====#
bivalve.collections.quota <-  #==== FILL IN HERE ====#
gastropod.collections.quota <-   #==== FILL IN HERE ====#
cephalopod.collections.quota <-  #==== FILL IN HERE ====#
fish.collections.quota <- #==== FILL IN HERE ====#
  
#And then use subsample_fossils to generate diversity curves:
#Note that these will do the subsampling 100 times to generate uncertainty around your results, so they can take a moment to finish running! 
#Look at the function script in Prac_9-10_functions.R to figure out what your inputs should be for the function.
  
subsampled.trilobites <- #==== FILL IN HERE ====#
subsampled.brachiopods <-  #==== FILL IN HERE ====#
subsampled.bivalves <-  #==== FILL IN HERE ====#
subsampled.gastropods <- #==== FILL IN HERE ====#
subsampled.cephalopods <-  #==== FILL IN HERE ====#
subsampled.fish <- #==== FILL IN HERE ====#


#==== Plot your results for Activity 1 - Part 3 ====# 
#Now, plot your subsampled richness curves for each taxonomic group
#Use different colored and shaped points to distinguish between your subsampled and raw values (saved in output_type)
#See handout for full guidance for how your final figures should look


  
  
  
  

#After making these figures initially, look to see how many of your richness measurements are just after mass extinction events.
#If you only have raw measurements right after your mass extinctions, try lowering you collections quota so that we have more accurate reading around mass extinction boundaries 
#Also, if your error bars are VERY large, you may want to increase your collections quota
#Again, this is balance! This activity may take some iterating



#And, congratulations!!! You have now generated subsampled biodiversity curves and you are well on your way to becoming quantitative palaeobiologists :)

