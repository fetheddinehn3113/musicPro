import 'package:flutter/material.dart';
import 'package:musicpro/const/constVar.dart';
import 'package:get/get.dart';
import '../const/playSongWidget.dart';
import '../const/tabBarItam.dart';
import '../const/tabBarWidget.dart';
import '../controlllers/homeController.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {


  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.8),
        appBar: AppBar(
          backgroundColor: KGrey,
          title: const Text("musicPro"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [tabBarItem("Songs"), tabBarItem("Favories")],
          ),
        ),
        body: GetBuilder<HomeController>(
          init: homeController,
          builder: (value) {
            return Stack(
              children: [
                Obx(
                  () => TabBarView(children: [
                    homeController.isProcessing.value
                        ? const Center(child: SizedBox(height:70,width: 70,child: CircularProgressIndicator(color: KBlue,)))
                        : tabBarModelSongs(context, homeController.songs),
                    homeController.isProcessing.value
                        ? const Center(child: SizedBox(height:70,width: 70,child: CircularProgressIndicator(color: KBlue,)))
                        :  tabBarModelFavorites(context, homeController.favorites)
                  ]),
                ),
                GetBuilder<HomeController>(
                  init: homeController,
                    builder: (value) {
                      return Positioned(
                          bottom: 0,
                          child: value.playSongDisplay
                              ? playSongModel(width, value.currentSong,value.currentFavoriteSong,value.currentList)
                              : const SizedBox());
                    })
              ],
            );
          }
        ),
      ),
    ));
  }
}
