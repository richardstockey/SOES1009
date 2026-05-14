#FUNCTIONS FOR SOES 1009 PRACTICAL 4 - BIODIVERSITY AND MASS EXTINCTIONS 

#========================================================================#
#           ACTIVITY 1 - GENERATING BIODIVERSITY CURVES  
#========================================================================#

#==== PART 2 - Sampling biases =====#
do_rarefaction <- function(continent_data, your.time, max.collections){
  
  #get stage data
  this.stage.data <- subset(continent_data, stage %in% your.time)
  stage.collections <- unique(this.stage.data$collection_no)
  
  if(max.collections>50){
    subsampling_sequence <- round(seq(from=1, to=max.collections, length.out=50))
    #dataframe to save results
    rarefy_results <- as.data.frame(matrix(NA, nrow=50, ncol=4)) 
    colnames(rarefy_results) <- c('continent', 'collections_sampled', 'richness', 'sd')
    rarefy_results$continent <- unique(continent_data$continent)
  } else if (max.collections <= 50){
    subsampling_sequence <- 1:max.collections
    rarefy_results <- as.data.frame(matrix(NA, nrow=max.collections, ncol=4)) 
    colnames(rarefy_results) <- c('continent', 'collections_sampled', 'richness', 'sd')
    rarefy_results$continent <- unique(continent_data$continent)
  }
  
  for(i in 1:length(subsampling_sequence)){
    
    n.collections <- subsampling_sequence[i]
    rarefy_results$collections_sampled[i] <- n.collections
    
    temp_results <- rep(NA, 100)
    
    for(iter in 1:100){
      
      rand.colls <- stage.collections[sample(max.collections, n.collections, replace=FALSE)]
      rand.data <- subset(this.stage.data, collection_no %in% rand.colls)
      richness <- length(unique(rand.data$genus))
      temp_results[iter] <- richness
      
    }
    
    rarefy_results$richness[i] <- mean(temp_results)
    rarefy_results$sd[i] <- sd(temp_results)
    
  }

  return(rarefy_results)
  
}


#==== PART 3 - Subsampling =====#

subsample_fossils <- function(taxonomic_data, n.collections, your_stages){
  
  data(stages)
  
  iters <- 100
  
  variables <- c('taxonomic_group', 'stage', 'mid_ma', 'richness', 'sd', 'output_type')
  results_df <- as.data.frame(matrix(NA, nrow=length(your_stages), ncol=length(variables)))
  colnames(results_df) <- variables
  
  for(i in 1:length(your_stages)){
    
    this.stage <- your_stages[i]
    results_df$stage[i] <- this.stage
    results_df$mid_ma[i] <- subset(stages, stage==this.stage)$mid
    this.stage.data <- subset(taxonomic_data, stage==this.stage)
    
    max.collections <- length(unique(this.stage.data$collection_no))
    stage.collections <- unique(this.stage.data$collection_no)
    
    temp.richness <- rep(NA, iters)
    
    if(max.collections>n.collections){
      for(j in 1:iters){
      
      rand.idxs <- sample(1:max.collections, n.collections, replace=FALSE)
      rand.collections <- stage.collections[rand.idxs]
      subbed.data <- subset(this.stage.data, collection_no %in% rand.collections)
      
      #get richness
      subbed.data.richness <- length(unique(subbed.data$genus))
      temp.richness[j] <- subbed.data.richness
      
      }
    } else if(max.collections<n.collections){
      temp.richness <- length(unique(this.stage.data$genus))
    }
    
    results_df$richness[i] <- mean(temp.richness, na.rm=TRUE)
    results_df$sd[i] <- sd(temp.richness, na.rm=TRUE)
    if(max.collections>n.collections){results_df$output_type[i]<-'subsampled'}
    else if(n.collections>max.collections){results_df$output_type[i]<-'raw'}
    
  }
  
  results_df <- subset(results_df, !is.na(richness))
  return(results_df)
  
}
