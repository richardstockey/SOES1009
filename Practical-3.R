# install packages that weren't installed in Practical 2
install.packages("sepkoski")
install.packages("dplyr")
# if you think you might be missing any packages (i.e. if you are using a different computer to last week),
# run install.packages.R from the module GitHub
#

# Tell R we want to use the sepkoski package
# this contains the data from Jack Sepkoski's famous compilation of fossil stratigraphic ranges
library(sepkoski)

# Store the package data as a dataframe that we can see in the Data section of our R environment (top right of your screen)
sepkoski <- sepkoski

# One cool thing this package does is make nice graphs of the Sepkoski data...
sepkoski_curve()

# We can also edit the aesthetics of those graphs
sepkoski_curve(title="Sepkoski's curve", col="black", fill=TRUE, legend=FALSE)

##########################################################################
# Working through Activity 3 tasks
##########################################################################

# Our aim is to plot stratigraphic ranges for key fossil animal groups

# The sepkoski data is split up by GENUS
# we can see this if we summarise the data frame
summary(sepkoski)

# or if we view the dataframe itself
View(sepkoski)

# To summarise by higher level taxonomic groups we will need to generate summary tables of the data
# The best way to do that (in my opinion... ) is using a brilliant package called dplyr
# You have been provided with a dplyr 'cheatsheet' in this practical.
# it can also be found here - https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

# lets load the dplyr package
library(dplyr)

# In dplyr we commonly use piping ("%>%" symbol) to pass data between functions.
# this can take a bit of getting used to, but is very helpful for writing neat code.

# In the below code, we pass the "sepkoski" data to the "group_by()" function
# this tells dplyr that when we generate our summary table we want to group all of the rows in our
# original data table into one category (phylum)

# we then 'pipe' ("%>%" symbol) this data again to the "summarise()" function.
# this enables us to generate summary data columns in our summary table.
# we can then define these columns
# Here we generate two columns
# 1. phylum_max_ma - using the "max()" function on all of the max_ma maximum age values for each genus within a grouping
# 2. phylum_min_ma - using the "min()" function on all of the min_ma minimum age values for each genus within a grouping

sepkoski_sum <- sepkoski %>%
  group_by(phylum) %>%
  summarise(phylum_max_ma = max(max_ma), phylum_min_ma = min(min_ma))


# We can then view the summary data frame that we have made
View(sepkoski_sum)

# now lets plot that summary!

# load the ggplot package
library(ggplot2)

# Now generate a geom_linerange plot using the summary data frame we just made!
ggplot(sepkoski_sum, aes(x = phylum, ymin = phylum_min_ma, ymax = phylum_max_ma))+
  geom_linerange()

# We can improve the aesthetics of this figure in a number of ways:
# 1. by reversing the y axis
ggplot(sepkoski_sum, aes(x = phylum, ymin = phylum_min_ma, ymax = phylum_max_ma))+
  geom_linerange()+
  scale_y_reverse()

# 2. by adding a white background
ggplot(sepkoski_sum, aes(x = phylum, ymin = phylum_min_ma, ymax = phylum_max_ma))+
  geom_linerange()+
  scale_y_reverse()+
  theme_bw()

# 3. by formatting our x axis labels to make them easier to read (you dont need to know why this works at this stage!)
ggplot(sepkoski_sum, aes(x = phylum, ymin = phylum_min_ma, ymax = phylum_max_ma))+
  geom_linerange()+
  scale_y_reverse()+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) # format our x axis labels to make them easier to read


# Save this figure as a pdf!

# Now, for your next task in Activity 3, you will want to conduct a similar exercise to generate a graph of
# the temporal ranges of different CLASSES of marine animals, colour coded by PHYLUM

# to get you started, your code might look something like....
# you will need to replace every instance of "xxx"
sepkoski_sum2 <- sepkoski %>%
  group_by(xxx, xxx) %>%
  summarise(class_max_ma = max(xxx), class_min_ma = min(xxx))

ggplot(sepkoski_sum2, aes(x = class, ymin = class_min_ma, ymax = class_max_ma))+
  geom_linerange(aes(colour = xxx))+
  scale_y_reverse()+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))




