import 'dart:io';

import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicpro/models/FavoritesModel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseFav {
  static const _databaseName = "favoritesDataBase.db";
  static const _databaseVersion = 1;
  static const table = "favorites";
  static const columnId = "id";
  static const columnTile = "title";
  static const columnDisplayName = "displayName";
  static const columnPath = "path";
  static const columnArtist = "artist";

  DatabaseFav._privateConstructor();

  static final DatabaseFav instance = DatabaseFav._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
// lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnTile Text,
          $columnDisplayName Text,
          $columnPath Text,
          $columnArtist Text
      )
     ''');
  }


  Future<void> addToFavorite(FavoritesModel song) async {
    Database db = await instance.database;
    await db.insert(table, {
      columnTile : song.title,
      columnPath: song.path,
      columnDisplayName: song.displayName,
      columnArtist: song.artist,
    });
  }

  Future<void> deleteFromFavorite(String path) async {
    Database db = await instance.database;
   await db.delete(
      table,
      where:
      "$columnPath = ?",
      whereArgs: [path],
    );
  }

  Future<List<FavoritesModel>> querryAllRows() async {
    Database db = await instance.database;
    var map =  await db.query(table);
    List<FavoritesModel> favorites =[];
    for(var item in map){
      favorites.add(FavoritesModel.fromJson(item));
    }
    return favorites;
  }

}
