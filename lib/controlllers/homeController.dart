
import 'package:shake/shake.dart';
import 'package:get/get.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:musicpro/database/database.dart';
import 'package:musicpro/models/FavoritesModel.dart';
class HomeController extends GetxController{


  ShakeDetector detector;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSongs();

     detector = ShakeDetector.autoStart(
         minimumShakeCount: 1,
         shakeSlopTimeMS: 500,
         shakeCountResetTime: 3000,
         shakeThresholdGravity: 2.7,
         onPhoneShake: () async {
        await playPause();
        
      },
    );


    audioManager.onEvents((events, args) async {
      switch (events) {
        case AudioManagerEvents.ended:
          currentList ==0 ? next():nextFavorites();
          break;
        case AudioManagerEvents.next:
          currentList ==0 ? next():nextFavorites();
          break;

        case AudioManagerEvents.previous:
          currentList ==0 ? previous():previousFavorites();
          break;
        default:
          break;
      }
    });

  }

  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final AudioManager audioManager = AudioManager.instance;
  List<SongInfo> songs =[];
  List<FavoritesModel> favorites = [];
  var isProcessing =false.obs;
  bool isPlaying =false ;
  int currentIndex;
  int currentList;

 var playSongDisplay = false;
  SongInfo currentSong ;
  FavoritesModel currentFavoriteSong;

  playSong(int index)async {
    currentList =0;
    isPlaying = true;
    playSongDisplay =true;
    currentSong =  songs[index];
    currentIndex = index;
    update();
    await audioManager.start("file://" + currentSong.filePath, currentSong.title,
        desc: currentSong.artist, cover: "assets/music.png");
  }

  playFavoriteSong(int index)async {
    currentList=1;
    isPlaying = true;
    playSongDisplay =true;
    currentFavoriteSong = favorites[index];
    currentIndex = index;
    update();
    await audioManager.start("file://" + currentFavoriteSong.path, currentFavoriteSong.title,
        desc: currentFavoriteSong.artist, cover: "assets/music.png");
  }

  switchPlaying(){
    isPlaying = !isPlaying;
    update();
  }

  switchList(int currentList){
    this.currentList =currentList;
  }



  playPause(){
    audioManager.playOrPause();
    isPlaying = !isPlaying;
    update();
  }

  nextFavorites(){
    if(currentIndex==favorites.length-1){
      currentIndex =-1;
    }
    playFavoriteSong(++currentIndex);
  }

  previousFavorites(){
    if(currentIndex==0){
      currentIndex =favorites.length;
    }
    playFavoriteSong(--currentIndex);
  }

  next(){
    if(currentIndex==songs.length-1){
      currentIndex =-1;
    }
    playSong(++currentIndex);
  }

  previous(){
    if(currentIndex==0){
      currentIndex =songs.length;
    }
    playSong(--currentIndex);
  }

  bool isFavorites(String path){
    for(var item in favorites){
      if(item.path==path){
        return true;
      }
    }
    return false;
  }

  switchBool(){
    isProcessing.value = !isProcessing.value;
    update();
  }


  addToFavorite()async{
    if(currentList ==0){
      await DatabaseFav.instance.addToFavorite(FavoritesModel(title: currentSong.title,displayName: currentSong.displayName,path: currentSong.filePath,artist: currentSong.artist));
    } else {
      await DatabaseFav.instance.addToFavorite(currentFavoriteSong);
    }
    await getFavorites();
    update();
  }

  deleteFromFavorite() async {
    await DatabaseFav.instance.deleteFromFavorite(currentList==0?currentSong.filePath:currentFavoriteSong.path);
    await getFavorites();
    update();
  }


  getSongs()async {
    switchBool();
    songs = await audioQuery.getSongs();
    favorites = await DatabaseFav.instance.querryAllRows();
    switchBool();
  }

  getFavorites() async {
    favorites = await DatabaseFav.instance.querryAllRows();
  }
}