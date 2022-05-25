import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicpro/controlllers/homeController.dart';
import 'package:musicpro/models/FavoritesModel.dart';
import 'constVar.dart';
import 'package:get/get.dart';

Widget playSongModel(
    double width, SongInfo song, FavoritesModel favorite, int from) {
  final controller = Get.find<HomeController>();
  if (from == 0) {
    bool favory = controller.isFavorites(song.filePath);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: KBlue),
          color: KGrey,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                song.title.length < 13
                    ? song.title
                    : song.title.substring(0, 13) + " , " + song.artist,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(

                  onTap: () {
                    favory = !favory;
                    if(!favory){
                      controller.deleteFromFavorite();
                    }else{
                      controller.addToFavorite();
                    }

                  },
                  child: Icon(favory
                      ? Icons.favorite
                      : Icons.favorite_border)),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    controller.previous();
                  },
                  child: const Icon(
                    Icons.skip_previous,
                    size: 40,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    controller.playPause();
                  },
                  child: Icon(
                      controller.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow_rounded,
                      size: 40),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                    onTap: () {
                      controller.next();
                    },
                    child: Icon(Icons.skip_next, size: 40)),
              ],
            ),
          )
        ],
      ),
    );
  } else {
    bool favory = controller.isFavorites(favorite.path);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: KBlue),
          color: KGrey,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                favorite.title.length < 13
                    ? favorite.title
                    : favorite.title.substring(0, 13) + " , " + favorite.artist,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                  onTap: () {
                    favory = !favory;
                    if(!favory){
                       controller.deleteFromFavorite();
                    }else{
                      controller.addToFavorite();
                    }
                  },
                  child: Icon(favory
                      ? Icons.favorite
                      : Icons.favorite_border)),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    controller.previousFavorites();
                  },
                  child: const Icon(
                    Icons.skip_previous,
                    size: 40,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    controller.playPause();
                  },
                  child: Icon(
                      controller.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow_rounded,
                      size: 40),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                    onTap: () {
                      controller.nextFavorites();
                    },
                    child: Icon(Icons.skip_next, size: 40)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
