import 'package:flutter_audio_query/flutter_audio_query.dart';

class FavoritesModel {
  int id;
  String displayName;
  String title;
  String path;
  String artist;

  FavoritesModel(
      {this.id, this.displayName, this.title, this.path, this.artist});

  factory FavoritesModel.fromJson(Map<String, dynamic> item) {
    return FavoritesModel(
        id: item["id"],
        displayName: item["displayName"],
        title: item["title"],
        path: item["path"],artist: item["artist"]);
  }

  @override
  String toString() {
    return 'FavoritesModel{id: $id, displayName: $displayName, tile: $title, path: $path, artist: $artist}';
  }
}
