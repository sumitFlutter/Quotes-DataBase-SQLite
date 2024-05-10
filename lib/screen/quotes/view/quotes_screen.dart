import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quotes_app_db/screen/database/model/db_quotes_model.dart';
import 'package:quotes_app_db/screen/details/controller/font_family_controller.dart';
import 'package:quotes_app_db/screen/home/controller/home_controller.dart';
import 'package:quotes_app_db/screen/quotes/controller/quotes_controller.dart';
import 'package:quotes_app_db/screen/splash/controller/network_controller.dart';

import '../../../main.dart';
import '../../../utils/helpers/db_helper.dart';
import '../../database/controller/db_controller.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  HomeController homeController=Get.put(HomeController());
  NetworkController networkController=Get.put(NetworkController());
  QuotesController quotesController=Get.put(QuotesController());
  DBController dbController=Get.put(DBController());
  FontFamilyController familyController=Get.put(FontFamilyController());
  bool isFromAPI=Get.arguments;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();}
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Obx(() => isFromAPI?Text(homeController.tagOfAPI.value,style: const TextStyle(fontWeight: FontWeight.bold),):Text(homeController.jsonModelList[homeController.indexJson.value].category!,style: const TextStyle(fontWeight: FontWeight.bold),))),
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
          Obx(() => isFromAPI?
          networkController.isConnected.value?
          homeController.quotesAPIModelList.isNotEmpty?ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                 quotesController.indexAPI.value=index;
                 quotesController.random(1, 21);
                quotesController.randomFontFamilyGetter(1, 15);
                 homeController.colorList.shuffle();
                 familyController.fontManager.value=quotesController.randomFont;
                 Get.toNamed("details",arguments: true);
                },
                child: Container(
                  color: homeController.colorList[index].shade400,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  height: 110,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          homeController.quotesAPIModelList[index].content!,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(onPressed: () {
                            DBQuotesModel d1=DBQuotesModel(quote: homeController.quotesAPIModelList[index].content!,category: homeController.tagOfAPI.value,author: homeController.quotesAPIModelList[index].author);
                            DBHelper.dbHelper.insertQuotes(d1);
                            dbController.readQuotes();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved SuccessFully")));
                          }, icon: Icon(Icons.favorite,color: Colors.pinkAccent.shade700,)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: homeController.quotesAPIModelList.length,
          ):
              const Center(child: CircularProgressIndicator(),):Center(child: Image.asset("assets/image/internet/no_internet.png",height: 216,width: 384,fit: BoxFit.cover,),)
              :ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  quotesController.fIndexJson.value=homeController.indexJson.value;
                  quotesController.lIndexJson.value=index;
                  quotesController.random(1, 21);
                 quotesController.randomFontFamilyGetter(0, 15);
                  homeController.colorList.shuffle();
                  familyController.fontManager.value=quotesController.randomFont;
                  Get.toNamed("details",arguments: false);
                },
                child: Container(
                  color: homeController.colorList[index].shade400,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  height: 110,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          homeController.jsonModelList[homeController.indexJson.value].quotesList![index].quote!,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(onPressed: () {
                            String quote=homeController.jsonModelList[homeController.indexJson.value].quotesList![index].quote!;
                            String author=homeController.jsonModelList[homeController.indexJson.value].quotesList![index].author!;
                            DBQuotesModel d1=DBQuotesModel(quote: quote,category: homeController.tagOfAPI.value,author:author);
                            DBHelper.dbHelper.insertQuotes(d1);
                            dbController.readQuotes();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved SuccessFully")));
                          }, icon: Icon(Icons.favorite,color: Colors.pinkAccent.shade700,)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: homeController.jsonModelList[homeController.indexJson.value].quotesList!.length,
          )
          ),
        ],
      )

    ),);
  }
}
