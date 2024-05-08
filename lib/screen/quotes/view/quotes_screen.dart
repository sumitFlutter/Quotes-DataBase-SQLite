import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_db/screen/home/controller/home_controller.dart';
import 'package:quotes_app_db/screen/splash/controller/network_controller.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  HomeController homeController=Get.put(HomeController());
  NetworkController networkController=Get.put(NetworkController());
  bool isFromAPI=Get.arguments;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Obx(() => isFromAPI?
      networkController.isConnected.value?ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              //  homeController.indexJson.value=index;
              //Get.toNamed("quotes",arguments:false);
            },
            child: Container(
              color: homeController.colorList[index].shade400,
              margin: const EdgeInsets.all(10),
              height: 100,
              child: Center(
                child: Text(
                  homeController.quotesAPIModelList[index].content!,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          );
        },
        itemCount: homeController.quotesAPIModelList.length,
      ):Center(child: CircularProgressIndicator(),)
          :ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              //  homeController.indexJson.value=index;
              //Get.toNamed("quotes",arguments:false);
            },
            child: Container(
              color: homeController.colorList[index].shade400,
              margin: const EdgeInsets.all(10),
              height: 100,
              child: Center(
                child: Text(
                  homeController.jsonModelList[homeController.indexJson.value].quotesList![index].quote!,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          );
        },
        itemCount: homeController.jsonModelList[homeController.indexJson.value].quotesList!.length,
      )
      )

    ),);
  }
}
