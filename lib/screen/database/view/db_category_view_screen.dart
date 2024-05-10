import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_db/screen/database/controller/db_controller.dart';
import 'package:quotes_app_db/screen/home/controller/home_controller.dart';
import 'package:quotes_app_db/screen/splash/controller/network_controller.dart';
import 'package:quotes_app_db/utils/helpers/db_helper.dart';

import '../../../main.dart';

class DBCategoryViewScreen extends StatefulWidget {
  const DBCategoryViewScreen({super.key});

  @override
  State<DBCategoryViewScreen> createState() => _DBCategoryViewScreenState();
}

class _DBCategoryViewScreenState extends State<DBCategoryViewScreen> {
  DBController dbController = Get.put(DBController());
  HomeController homeController = Get.put(HomeController());
  NetworkController networkController = Get.put(NetworkController());

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        Obx(() => networkController.isConnected.value
            ? SizedBox(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: Obx(
                  () => ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ColoredBox(
                          color: homeController.colorList[index].shade400,
                          child: ListTile(
                            onTap: () {
                              if(dbController.dbCategoryModelList[index].index==1000)
                                {
                                  homeController.quotesAPIModelList.value=[];
                                  homeController.getAPIQuotesList(dbController.dbCategoryModelList[index].category!);
                                  homeController.colorList.shuffle();
                                  Get.toNamed("quotes",arguments:true);
                                }
                              else{
                                homeController.indexJson.value=dbController.dbCategoryModelList[index].index!;
                                homeController.colorList.shuffle();
                                Get.toNamed("quotes",arguments:false);
                              }
                            },
                            title: Text(dbController
                                .dbCategoryModelList[index].category!,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                            subtitle: const Text("Tap me to view  My Quotes:",style: TextStyle(color: Colors.black),),
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      title: Text("Are you sure?"),
                                      actions: [
                                        ElevatedButton(onPressed: () {
                                          Navigator.pop(context);
                                        }, child: Text("No!")),
                                        ElevatedButton(onPressed: () {
                                          DBHelper.dbHelper.deleteCategory(
                                              id: dbController
                                                  .dbCategoryModelList[index].id!);
                                          dbController.readCategory();
                                          Navigator.pop(context);
                                        }, child: Text("Yes!"))
                                      ],
                                    );
                                  },);
                                  },
                                icon: Icon(Icons.delete,color: Colors.black,)),
                          ),
                        ),
                      );
                    },
                    itemCount: dbController.dbCategoryModelList.length,
                  ),
                ),
              )
            : SizedBox(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: Center(
                  child: Image.asset(
                    "assets/image/internet/no_internet.png",
                    height: 216,
                    width: 384,
                    fit: BoxFit.cover,
                  ),
                )))
      ],
    );
  }
}
