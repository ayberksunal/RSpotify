
#to write the frame to cvs
write.csv(featuresEurovision, file = "MyDatafeaturesEurovision.csv")

colors = c("red", "yellow", "green", "violet", "orange","blue", "pink", "cyan")

correlationValue<-cor(featuresEurovision$danceability,featuresEurovision$energy)

stringCorrelation<-paste("Dancebility (Correlation =" , correlationValue,")")

plot(featuresEurovision$danceability,featuresEurovision$energy,col ="red",xlab =stringCorrelation,ylab = "Energy")


#histogram of eurovision winners  and energy
hist(Winners$energy,  right=FALSE, col=colors, main="Winners 2000-2018",  xlab="Low Energy to High Energy",ylab = "Number of Winning")

#histogram of energy and how many song 
hist(featuresEurovision$energy,  right=FALSE, col=colors, main="Songs 2000-2018",  xlab="Low Energy to High Energy",ylab = "How many songs")

#birinci gelenlerin yıl ve enerji
plot(birinciGelenYilli$X..Yil..,birinciGelenYilli$X..energy..,col="red",xlab = "years",ylab = "energy")
