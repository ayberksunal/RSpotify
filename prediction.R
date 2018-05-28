library(class)

#to shuffle the rows
#we do not wanna sorted years
eurovisionSorted<-featuresEurovision2[order(featuresEurovision2$danceability),]

#to get the all columns we want
eurovisionPredictionData <- eurovisionSorted[1:591,4:15]

#gets out of prediction columns
trainingSet <- eurovisionPredictionData[1:491, 1:11]
testSet <- eurovisionPredictionData[492:591, 1:11]

#gets prediction columns
trainingOutcomes <- eurovisionPredictionData[1:491, 12]
testOutcomes <- eurovisionPredictionData[492:591, 12]


#train the machine
predictions <- knn(train = trainingSet, cl = trainingOutcomes, k = 5,test = testSet)

table(predictions,testOutcomes)


deneme<-subset(eurovisionSorted ,select=c("danceability","energy","key","loudness","mode","speechiness","acousticness" ,"instrumentalness", "liveness","valence","tempo","duration_ms","time_signature", "Yıl","Enerjisi"))

##########################################################################################
