
library(devtools)
library(Rspotify)

#To contact with  API service by appID  cliend_ID and Client_Secret
#They can be reached from the website of spotify
keys <- spotifyOAuth(app_id = "ayberk", client_id = "782a5daa8f574ba0bcaf9e8af852ad07", client_secret = "b1d2f5ce612e46c5a893db6099a5a2ec")
eurovisionPlaylists_Years_cleared<-data.frame()

#Finds the all playlist of the user with 50 offset
#Offset determines the limit of rows
eurovisionPlaylists_Years<-getPlaylist("1116592061",offset=50,token=keys);

#To erase the wanted rows 
#an other way it using "filter"
for (i in 34:50){
  eurovisionPlaylists_Years_cleared<-data.frame(rbind(eurovisionPlaylists_Years_cleared,eurovisionPlaylists_Years[i,1:3]))
}

#empty frame to store each features of songs
featuresEurovision<-data.frame()

#to store the result 
Sonuc<-data.frame(id="1",yıl="yıl",oran=0,danceability='Bilinmiyor')
#loops all rows of playslist
#to look the songs of these playlists
for(i in 2:length(eurovisionPlaylists_Years_cleared$id))
{
 
  #to see which country's id consuming
  eurovision_playlist<-data.frame()
  print(eurovisionPlaylists_Years_cleared$name[i])
  eurovision_playlist<-data.frame()
  #to find all song of one country
  eurovision_playlist <- getPlaylistSongs("1116592061",eurovisionPlaylists_Years_cleared$id[i],token=keys)
  #features["countryname"]<-allPlaylistsInfo$name[1]
  
  #stores row number of playlist for forloop
  rowNumber<-c(dim(eurovision_playlist))
  rowNumber<-c(rowNumber[1])
  count<-0
  #looks all song of playlists
  for(a in eurovision_playlist$id){
    Sys.sleep(0.09)
    count<-count+1
    
    #to get JSON result
    req <- httr::GET(paste0("https://api.spotify.com/v1/audio-features/", 
                            a), httr::config(token = keys))
    json1 <- httr::content(req)
    dadosEuro = data.frame(id = json1$id, danceability = json1$danceability, 
                       energy = json1$energy, key = json1$key, loudness = json1$loudness, 
                       mode = json1$mode, speechiness = json1$speechiness, 
                       acousticness = json1$acousticness, instrumentalness = json1$instrumentalness, 
                       liveness = json1$liveness, valence = json1$valence, 
                       tempo = json1$tempo, duration_ms = json1$duration_ms, 
                       time_signature = json1$time_signature,
                       stringsAsFactors = F)
    #adds the name of the list
    dadosEuro$Yıl<-eurovisionPlaylists_Years_cleared$name[i]
    featuresEurovision <- rbind( featuresEurovision, dadosEuro)
    
  }
  print(count)
  
}


# It clusters all songs by their energy column 
# clustering depends on quantiles levels
featuresEurovisionBirUlke2$Enerjisi<-"Bilinmiyor"
#featuresEurovisionBirUlke2<-featuresEurovisionBirUlke
quantilesEurovision<-quantile(featuresEurovisionBirUlke2$energy)
for(k in 1:nrow(featuresEurovisionBirUlke2)){
  if(featuresEurovisionBirUlke2$energy[k] < quantilesEurovision[2]){
    featuresEurovisionBirUlke2$Enerjisi[k] = "Low Energic"
  }
  if(featuresEurovisionBirUlke2$energy[k] >= quantilesEurovision[2] && featuresEurovisionBirUlke2$energy[k] < quantilesEurovision[4])
  {
    featuresEurovisionBirUlke2$Enerjisi[k]='Energic'
  }
  
  if(featuresEurovisionBirUlke2$energy[k] > quantilesEurovision[4] ){
    featuresEurovisionBirUlke2$Enerjisi[k]='High Energic'
  }
}


  
  ############################################ COMMENT THIS PART BEFORE RUN########################################
#To find the winners of each years song features
featuresEurovisionBirUlke<-data.frame()

Sonuc<-data.frame(id="11111111",yıl="yıl",oran=0000,danceability='Bilinmiyor')
for(i in 1:length(eurovisionPlaylists_Years_cleared$id))
{
  #to see which country's id consuming
  eurovision_playlist<-data.frame()
  print(eurovisionPlaylists_Years_cleared$name[i])
  eurovision_playlist<-data.frame()
  #tek ulkenın tüm sarkıları
  eurovision_playlist <- getPlaylistSongs("1116592061",eurovisionPlaylists_Years_cleared$id[i],token=keys)
  #features["countryname"]<-allPlaylistsInfo$name[1]
  
  rowNumber<-c(dim(eurovision_playlist))
  rowNumber<-c(rowNumber[1])
  count<-0
  for(a in 1:1){
    Sys.sleep(0.01)
    count<-count+1
    #  cc<-data.frame(eurovision_playlist[a,2])
    req <- httr::GET(paste0("https://api.spotify.com/v1/audio-features/", 
                            eurovision_playlist$id[a]), httr::config(token = keys))
    json1 <- httr::content(req)
    dadosEurobirUlke<-data.frame()
    dadosEurobirUlke = data.frame(id = json1$id, danceability = json1$danceability, 
                           energy = json1$energy, key = json1$key, loudness = json1$loudness, 
                           mode = json1$mode, speechiness = json1$speechiness, 
                           acousticness = json1$acousticness, instrumentalness = json1$instrumentalness, 
                           liveness = json1$liveness, valence = json1$valence, 
                           tempo = json1$tempo, duration_ms = json1$duration_ms, 
                           time_signature = json1$time_signature,
                           stringsAsFactors = F)
    #adds the name of the list
    dadosEurobirUlke$Yıl<-eurovisionPlaylists_Years_cleared$name[i]
    featuresEurovision <- rbind( featuresEurovision, dadosEurobirUlke)
    
  }
  print(count)
  
}

############################################ COMMENT THIS PART BEFORE RUN########################################













