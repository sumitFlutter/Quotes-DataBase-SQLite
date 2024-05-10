import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quotes_app_db/main.dart';
import 'package:quotes_app_db/screen/details/controller/font_family_controller.dart';
import 'package:quotes_app_db/screen/home/controller/home_controller.dart';
import 'package:quotes_app_db/screen/quotes/controller/quotes_controller.dart';

import '../../../utils/helpers/db_helper.dart';
import '../../database/controller/db_controller.dart';
import '../../database/model/db_quotes_model.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isFromAPI = Get.arguments;
  QuotesController quotesController = Get.put(QuotesController());
  HomeController homeController = Get.put(HomeController());
  FontFamilyController familyController=Get.put(FontFamilyController());
  DBController dbController=Get.put(DBController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Obx(() => isFromAPI?Text(homeController.tagOfAPI.value,style: const TextStyle(fontWeight: FontWeight.bold),):Text(homeController.jsonModelList[homeController.indexJson.value].category!,style: const TextStyle(fontWeight: FontWeight.bold),)),
        actions: [
          IconButton(onPressed: () {
            if(isFromAPI) {
              DBQuotesModel d1 = DBQuotesModel(
                  quote: homeController.quotesAPIModelList[quotesController.indexAPI.value].content!,
                  category: homeController.tagOfAPI.value,
                  author: homeController.quotesAPIModelList[quotesController.indexAPI.value].author);
              DBHelper.dbHelper.insertQuotes(d1);
              dbController.readQuotes();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Saved SuccessFully")));
            }
            else{
              String quote=homeController.jsonModelList[quotesController.fIndexJson.value].quotesList![quotesController.lIndexJson.value].quote!;
              String author=homeController.jsonModelList[quotesController.fIndexJson.value].quotesList![quotesController.lIndexJson.value].author!;
              DBQuotesModel d1=DBQuotesModel(quote: quote,category: homeController.tagOfAPI.value,author:author);
              DBHelper.dbHelper.insertQuotes(d1);
              dbController.readQuotes();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved SuccessFully")));

            }
              }, icon: Icon(Icons.favorite,color: Colors.pinkAccent.shade700,)),
          ],),
        body: Stack(
          children: [
            Obx(
                  () => Image.asset(
                themeController.bgImage.value,
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Stack(
                      children: [
                        Image.asset(
                          "assets/image/background/${quotesController.randomWallpaper}.jpeg",
                          height: MediaQuery.sizeOf(context).height*0.78,
                          width: MediaQuery.sizeOf(context).width,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).height*0.78,
                          width: MediaQuery.sizeOf(context).width,
                          padding: const EdgeInsets.all(12),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                isFromAPI
                                    ? Text(
                                        homeController
                                            .quotesAPIModelList[
                                                quotesController.indexAPI.value]
                                            .content!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          fontFamily: "s${familyController.fontManager.value}",
                                          color:
                                              quotesController.randomWallpaper.value ==
                                                          1 ||
                                                      quotesController
                                                              .randomWallpaper.value ==
                                                          4 ||
                                                      quotesController
                                                              .randomWallpaper.value ==
                                                          14 ||
                                                      quotesController
                                                              .randomWallpaper.value ==
                                                          17 ||
                                                      quotesController
                                                              .randomWallpaper.value ==
                                                          18 ||
                                                      quotesController
                                                              .randomWallpaper.value ==
                                                          19
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      )
                                    : Text(
                                        homeController
                                            .jsonModelList[
                                                quotesController.fIndexJson.value]
                                            .quotesList![
                                                quotesController.lIndexJson.value]
                                            .quote!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          fontFamily: "s${familyController.fontManager.value}",
                                          color:
                                              quotesController.randomWallpaper.value ==
                                                          1 ||
                                                      quotesController
                                                              .randomWallpaper.value ==
                                                          4 ||
                                                      quotesController
                                                              .randomWallpaper.value ==
                                                          14 ||
                                                      quotesController
                                                              .randomWallpaper.value ==
                                                          17 ||
                                                      quotesController
                                                              .randomWallpaper.value ==
                                                          18 ||
                                                      quotesController
                                                              .randomWallpaper.value ==
                                                          19
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                const SizedBox(height: 16,),
                                Align(alignment: Alignment.centerRight,
                                  child: isFromAPI
                                      ? Text(
                                    homeController
                                        .quotesAPIModelList[
                                    quotesController.indexAPI.value]
                                        .author!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      fontFamily: "s${familyController.fontManager.value}",
                                      color:
                                      quotesController.randomWallpaper.value ==
                                          1 ||
                                          quotesController
                                              .randomWallpaper.value ==
                                              4 ||
                                          quotesController
                                              .randomWallpaper.value ==
                                              14 ||
                                          quotesController
                                              .randomWallpaper.value ==
                                              17 ||
                                          quotesController
                                              .randomWallpaper.value ==
                                              18 ||
                                          quotesController
                                              .randomWallpaper.value ==
                                              19
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  )
                                      : Text(
                                    homeController
                                        .jsonModelList[
                                    quotesController.fIndexJson.value]
                                        .quotesList![
                                    quotesController.lIndexJson.value]
                                        .author!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      fontFamily: "s${familyController.fontManager.value}",
                                      color:
                                      quotesController.randomWallpaper.value ==
                                          1 ||
                                          quotesController
                                              .randomWallpaper.value ==
                                              4 ||
                                          quotesController
                                              .randomWallpaper.value ==
                                              14 ||
                                          quotesController
                                              .randomWallpaper.value ==
                                              17 ||
                                          quotesController
                                              .randomWallpaper.value ==
                                              18 ||
                                          quotesController
                                              .randomWallpaper.value ==
                                              19
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2,),
                  const Text("FontFamilies",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                  Expanded(child:
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          familyController.fontManager.value=familyController.fontList[index];
                        },
                        child: Obx(
                          () => Container(margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(border:familyController.fontManager.value==familyController.fontList[index]?Border.all(color: Colors.yellow,width: 2):const Border(),color: Colors.transparent),
                          child: Text("Aa",style: TextStyle(fontFamily: "s${familyController.fontList[index]}",fontSize: 22,color: Colors.white),),),
                        ),
                      );
                    },
                    itemCount: familyController.fontList.length,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
