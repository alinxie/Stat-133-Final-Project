#Do total variation analysis between two distributions of y in each data set df1
#and df2
#Hypothesis, the total variation distance between two distributions is 0,
#Reject if p-value < 0.05
tvd_analysis <- function(df1, df2, y) {
  tvd <- get_tvd(df1$y, df2$y)
  #Simulate tvds between df1 and tables with same probability distribution as df1
  #Add each tvd to sample_tvds
  sample_tvds <- numeric(0);
  for (i in 1:10000) {
    sample <- rmultinom(1, sum(df1$y), df1$y)[,1]
    sample_tvds[i] <- get_tvd(df1$y, sample)
  }
  #p-value: Proportion of sample tvds that are greater than our test statistic tvd
  p_value <- (sample_tvds >= tvd) / length(sample_tvds)
  print(paste("tvd statistic: ", tvd))
  print(paste("p-value:",p_value))
  if (p_value < 0.05) {
    print("Distributions not equal")
    print("Since the second distribution has a tvd with the first distribution 
            that is greater than 95% of the expected tvds between the first 
            distribution and itself, we can reject the null hypothesis that the 
            first and second distributions are equal")
  } else {
    print("Since the second distribution has a tvd with the first distribution 
            that is less than 95% of the expected tvds between the first 
            distribution and itself, we cannot reject the null hypothesis that the 
            first and second distributions are equal")
  }
}

#Get the total variation distance between vec1 and vec2
#Total variation distance is in short the distance between y values for
#categorical x values between 2 datasets
get_tvd <- function(vec1, vec2) {
  # sum of vectors for normalization purposes
  sum_1 <- sum(vec1)
  sum_2 <- sum(vec2)
  # normalized vectors
  normalized_1 <- vec1 / sum_1
  normalized_2 <- vec2 / sum_2
  #tvd is the sum of the differences between normalized vectors
  differences <- abs(normalized_1 - normalized_2)
  tvd <- sum(differences)
  return(tvd)
}