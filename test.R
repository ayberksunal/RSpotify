

library(devtools)
library(Rspotify)


#To contact with  API service by appID  cliend_ID and Client_Secret
#They can be reached from the website of spotify
keys <- spotifyOAuth(app_id = "ayberkdeneme", client_id = "782a5daa8f574ba0bcaf9e8af852ad07", client_secret = "b1d2f5ce612e46c5a893db6099a5a2ec")

#countrie's names to find the playlists
spotifyContries<- " TOP 50 Belgium, TOP 50 Czech Republic, TOP 50 Denmark, TOP 50 Estonia, TOP 50 Finland, TOP 50 France, TOP 50 Germany, TOP 50 Greece, TOP 50 Iceland, TOP 50 Ireland, TOP 50 Italy, TOP 50 Latvia, TOP 50 Lithuania, TOP 50 Netherlands, TOP 50 Norway, TOP 50 Poland, TOP 50 Portugal, TOP 50 Slovakia, TOP 50 Spain, TOP 50 Sweden, TOP 50 Switzerland, TOP 50 Turkey"
#data fram of all countries with splitting ","
countriesPlayListName<- matrix(unlist(strsplit(spotifyContries, split = ", ")), byrow=T)




#to find the playlist
allPlaylistsInfo<-data.frame()
for(b in countriesPlayListName){
  #all playslist which have this name
  foundPlaylistes <- searchPlaylist(b,0,token=keys)
  #only have list of "kolibrimusic"
  foundPlaylistes <- subset(foundPlaylistes,foundPlaylistes$owner == "kolibrimusic")
  #id nuber off all "kolibrimusic"
  allPlaylistsInfo <- data.frame(rbind( allPlaylistsInfo, foundPlaylistes))
  }



features<-data.frame()
Sonuc<-data.frame(id="1",ulke="ulkeismi",oran=0,Hareketlilik='Bilinmiyor')
for(i in 1:length(allPlaylistsInfo$id))
  {
  #to see which country's id consuming
  print(allPlaylistsInfo$name[i])
  allSongsOf_Country<-data.frame
  #tek ulkenın tüm sarkıları
  allSongsOf_Country <- data.frame(getPlaylistSongs("kolibrimusic",allPlaylistsInfo$id[i],token=keys))
  features<-data.frame()
  
  for(j in allSongsOf_Country$id)
    {
    #We need sleep mfunction
    #because internet speed sometimes not enough to handle with Json speed
    Sys.sleep(0.05)
    
    print("********************New Song Readed************")
    #JSON request
    req <- httr::GET(paste0("https://api.spotify.com/v1/audio-features/", 
                            j), httr::config(token = keys))
    json1 <- httr::content(req)
    dados = data.frame(id = json1$id, danceability = json1$danceability, 
                       energy = json1$energy, key = json1$key, loudness = json1$loudness, 
                       mode = json1$mode, speechiness = json1$speechiness, 
                       acousticness = json1$acousticness, instrumentalness = json1$instrumentalness, 
                       liveness = json1$liveness, valence = json1$valence, 
                       tempo = json1$tempo, duration_ms = json1$duration_ms, 
                       time_signature = json1$time_signature, uri = json1$uri, 
                       analysis_url = json1$analysis_url, stringsAsFactors = F)
  
 
    features <- rbind( features, dados)
  }
  print("-----------------------End Of Country-------------")
  #calcualtes the energy level
  resultOfSum <- features$danceability + features$energy
  totalNumber<-sum(resultOfSum)
  eklenecekRowSonuc<-data.frame(id=allPlaylistsInfo$id[i],ulke=allPlaylistsInfo$name[i],oran=totalNumber,Hareketlilik='Bilinmiyor')
  Sonuc<- data.frame(rbind( Sonuc , eklenecekRowSonuc))
  Sonuc$Hareketlilik="Bilinmiyor"
}



#determines the "hareketlilik" with quantiles lever
oranSınıflandırma<-quantile(Sosnuc$oran)
medianValue<-median(Sonuc$oran)
for(k in 2:nrow(Sonuc)){
  if(Sonuc$oran[k] < oranSınıflandırma[2]){
    Sonuc$Hareketlilik[k] = "Hareketsiz"
  }
  if(Sonuc$oran[k] >= oranSınıflandırma[2] && Sonuc$oran[k] < oranSınıflandırma[4])
  {
    Sonuc$Hareketlilik[k]='Az Hareketli'
  }
  
  if(Sonuc$oran[k] > oranSınıflandırma[4] ){
    Sonuc$Hareketlilik[k]='Cok Hareketli'
  }
  
}







