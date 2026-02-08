#GENOME SIZE ESTIMATION USING KMERs
#For a given sequence of length L,  and a k-mer size of k, the total k-mer’s possible will be given by ( L – k ) + 1
#Genome size: N = Total no. of k-mers/Coverage

#K-mer histo with Jellyfish
#Plot the data

#isolateID in this example was CAG-6
dataframe1 <- read.table("/path/to/reads/[isolateID]_reads.histo")
head(dataframe1)
tail(dataframe1)
plot(dataframe1[1:200,], type="l") #Plots the data points 1 through 200 in the dataframe using a line

#Determine the single copy region
plot(dataframe1[17:200,], type="l")
points(dataframe1[17:200,])

sum(as.numeric(dataframe1[17:6270,1]*dataframe1[17:6270,2]))
#result
#[1] 1206421517

#Determine peak position and genome size
dataframe1[15:30,]
#peak at 24

#Estimate genome size
sum(as.numeric(dataframe1[17:6270,1]*dataframe1[17:6270,2]))/24

#result
#[1] 50267563 ~50 Mb

#Proportion of single copy region to total genome size
sum(as.numeric(dataframe1[17:50,1]*dataframe1[17:50,2]))/24

#result
#[1] 34019112 ~34 Mb

sum(as.numeric(dataframe1[17:50,1]*dataframe1[17:50,2]))/sum(as.numeric(dataframe1[17:6270,1]*dataframe1[17:6270,2]))
#result
#[1] 0.6767607 67.7%

#Compare the peak shape with Poisson distribution
singleC <- sum(as.numeric(dataframe1[17:50,1]*dataframe1[17:50,2]))/24
poisdtb <- dpois(15:100,24)*singleC
plot(poisdtb, type='l', lty=2, col="green")
lines(dataframe1[15:200,] * singleC, type = "l", col=3)#, Ity=2)
lines(dataframe1[15:200,],type= "l")
