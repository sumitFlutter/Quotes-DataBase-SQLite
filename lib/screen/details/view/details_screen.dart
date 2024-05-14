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
          IconButton(onPressed: () async {
            if(isFromAPI) {
              if(await DBHelper.dbHelper.readSQ(homeController.quotesAPIModelList[quotesController.indexAPI.value].content!)==true)
            {
            DBQuotesModel db=DBQuotesModel(author: homeController.quotesAPIModelList[quotesController.indexAPI.value].author!,quote: homeController.quotesAPIModelList[quotesController.indexAPI.value].content!,category: homeController.tagOfAPI.value);
            DBHelper.dbHelper.insertQuotes(db);
            dbController.readQuotes();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SucessFully Added")));
            }
            else{
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Already Added")));
            }

            }
            else{
              String quote=homeController.jsonModelList[quotesController.fIndexJson.value].quotesList![quotesController.lIndexJson.value].quote!;
              String author=homeController.jsonModelList[quotesController.fIndexJson.value].quotesList![quotesController.lIndexJson.value].author!;
              if(await DBHelper.dbHelper.readSQ(quote)==true)
              {
                DBQuotesModel d1=DBQuotesModel(quote: quote,category: homeController.jsonModelList[quotesController.fIndexJson.value].category!,author:author);
                DBHelper.dbHelper.insertQuotes(d1);
                dbController.readQuotes();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SucessFully Added")));
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Already Added")));
              }
            }
              }, icon: Icon(Icons.favorite,color: Colors.pinkAccent.shade700,)),
          ],),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height*0.75,
                          width: MediaQuery.sizeOf(context).width,
                          child: Center(
                            child:Image.asset("assets/image/background/${quotesController.randomWallpaper}.jpg",
                            height: MediaQuery.sizeOf(context).height*0.33,width: MediaQuery.sizeOf(context).width,fit: BoxFit.cover,),
                          ),
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).height*0.78,
                          width: MediaQuery.sizeOf(context).width,
                          padding: const EdgeInsets.all(12),
                          child: Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.sizeOf(context).height*0.33,width: MediaQuery.sizeOf(context).width,
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
                                            fontSize: 18,
                                            color: quotesController.randomWallpaper.value==1||quotesController.randomWallpaper.value==3||quotesController.randomWallpaper.value==5||quotesController.randomWallpaper.value==6||quotesController.randomWallpaper.value==7||quotesController.randomWallpaper.value==8||quotesController.randomWallpaper.value==9||quotesController.randomWallpaper.value==11||quotesController.randomWallpaper.value==12||quotesController.randomWallpaper.value==17?Colors.black:Colors.white,
                                            fontFamily: "s${familyController.fontManager.value}",
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
                                            fontSize: 18,
                                            color: quotesController.randomWallpaper.value==1||quotesController.randomWallpaper.value==3||quotesController.randomWallpaper.value==5||quotesController.randomWallpaper.value==6||quotesController.randomWallpaper.value==7||quotesController.randomWallpaper.value==8||quotesController.randomWallpaper.value==9||quotesController.randomWallpaper.value==11||quotesController.randomWallpaper.value==12||quotesController.randomWallpaper.value==17?Colors.black:Colors.white,
                                            fontFamily: "s${familyController.fontManager.value}",
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
                                        fontSize:18,
                                        color: quotesController.randomWallpaper.value==1||quotesController.randomWallpaper.value==3||quotesController.randomWallpaper.value==5||quotesController.randomWallpaper.value==6||quotesController.randomWallpaper.value==7||quotesController.randomWallpaper.value==8||quotesController.randomWallpaper.value==9||quotesController.randomWallpaper.value==11||quotesController.randomWallpaper.value==12||quotesController.randomWallpaper.value==17?Colors.black:Colors.white,
                                        fontFamily: "s${familyController.fontManager.value}",
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
                                        fontSize: 18,
                                        color: quotesController.randomWallpaper.value==1||quotesController.randomWallpaper.value==3||quotesController.randomWallpaper.value==5||quotesController.randomWallpaper.value==6||quotesController.randomWallpaper.value==7||quotesController.randomWallpaper.value==8||quotesController.randomWallpaper.value==9||quotesController.randomWallpaper.value==11||quotesController.randomWallpaper.value==12||quotesController.randomWallpaper.value==17?Colors.black:Colors.white,
                                        fontFamily: "s${familyController.fontManager.value}",
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
                          child: Text("Aa",style: TextStyle(fontFamily: "s${familyController.fontList[index]}",fontSize: 22),),),
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
