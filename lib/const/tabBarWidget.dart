import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get.dart';
import 'package:musicpro/controlllers/homeController.dart';
import 'package:musicpro/models/FavoritesModel.dart';
Widget tabBarModelSongs(BuildContext context, List<SongInfo> songs) {
  final controller = Get.find<HomeController>();
  return ListView.separated(
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            controller.playSong(index);
          },
          child: Card(
            color: Colors.white,
            child: ListTile(
              leading: Image.asset("assets/music.png"),
              title: Text(songs[index].title,style: TextStyle(color: Colors.black),),
              subtitle: Text(songs[index].artist,style: TextStyle(color: Colors.black)),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10,);
      },
      itemCount: songs.length);
}

Widget tabBarModelFavorites(BuildContext context, List<FavoritesModel> favorites) {
  final controller = Get.find<HomeController>();
  return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            controller.playFavoriteSong(index);
          },
          child: Card(
            color: Colors.white,
            child: ListTile(
              leading: Image.asset("assets/music.png"),
              title: Text(favorites[index].title,style: TextStyle(color: Colors.black),),
              subtitle: Text(favorites[index].artist,style: TextStyle(color: Colors.black)),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10,);
      },
      itemCount: favorites.length);
}
