import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_db/screen/database/controller/db_controller.dart';
import 'package:quotes_app_db/screen/database/model/db_category_model.dart';
import 'package:quotes_app_db/screen/home/controller/home_controller.dart';
import 'package:quotes_app_db/screen/splash/controller/network_controller.dart';
import 'package:quotes_app_db/utils/helpers/db_helper.dart';

import '../../../main.dart';
import '../../details/controller/font_family_controller.dart';
import '../../home/model/api_quotes_model.dart';
import '../../quotes/controller/quotes_controller.dart';

class DBCategoryViewScreen extends StatefulWidget {
  const DBCategoryViewScreen({super.key});

  @override
  State<DBCategoryViewScreen> createState() => _DBCategoryViewScreenState();
}

class _DBCategoryViewScreenState extends State<DBCategoryViewScreen> {
  DBController dbController = Get.put(DBController());
  HomeController homeController = Get.put(HomeController());
  NetworkController networkController = Get.put(NetworkController());
  QuotesController quotesController = Get.put(QuotesController());
  FontFamilyController familyController = Get.put(FontFamilyController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => networkController.isConnected.value
        ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
                children: [
          Obx(
            () => SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.08,
              child: dbController.dbCategoryModelList.isNotEmpty?ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return
                  Obx(
                        () => InkWell(
                          onTap: () {
                            if(dbController.dbCategoryModelList[index].index==1000)
                              {
                                dbController.isFromAPIData.value=true;
                                dbController.getAPIQuotesList(dbController.dbCategoryModelList[index].category!);
                                dbController.dbCateModel.value=dbController.dbCategoryModelList[index];
                              }
                            else{
                              dbController.indexJsonData.value=dbController.dbCategoryModelList[index].index!;
                              dbController.isFromAPIData.value=false;
                              dbController.dbCateModel.value=dbController.dbCategoryModelList[index];
                            }
                          },
                          child: Container(
                                              width: 120,
                                              decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(20),
                          color: themeController
                              .pTheme.value
                              ? dbController.dbCateModel.value.category
                              ==
                              dbController.dbCategoryModelList.value[index].category
                              ? Colors.black54
                              : Colors.grey.shade100
                              : dbController.dbCateModel.value.category
                              ==
                              dbController.dbCategoryModelList.value[index].category                          ? Colors.green.shade300
                              : Colors.black,
                                              ),
                                              margin: const EdgeInsets.all(12),
                                              child: Center(
                          child: Text(
                            dbController.dbCategoryModelList[index].category!,
                            style: TextStyle(
                              color: themeController
                                  .pTheme.value
                                  ? dbController.dbCateModel.value.category
                                  ==
                                  dbController.dbCategoryModelList.value[index].category
                                  ? Colors.white
                                  : Colors.black
                                  : dbController.dbCateModel.value.category
                                    ==
                                    dbController.dbCategoryModelList.value[index].category
                                            ? Colors.black
                                            : Colors.white,
                            ),
                          ),
                                              ),
                                            ),
                        ),
                  );
              },itemCount: dbController.dbCategoryModelList.length,):
                  const Center(child: Text("Like a category to see liked categories"),)
            ),
          ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Obx(
                          () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dbController.dbCateModel.value.category==null
                              ? const Text("Select Category")
                              :
                              Text(dbController.dbCateModel.value.category!)
                              ,
                          dbController.dbCateModel.value.category!=null?
                          IconButton.filledTonal(
                              onPressed: () {
                                showDialog(context: context, builder: (context) {
                                  return AlertDialog(
                                    title: Text("Are you sure?"),
                                    actions: [
                                      ElevatedButton(onPressed: () {
                                        Navigator.pop(context);
                                      }, child: Text("No!")),
                                      ElevatedButton(onPressed: () {
                                        DBHelper.dbHelper.deleteCategory(id: dbController.dbCateModel.value.id!);
                                        dbController.readCategory();
                                        dbController.dbCateModel.value=DBCategoryModel();
                                        Navigator.pop(context);
                                      }, child: Text("Yes!"))
                                    ],
                                  );
                                },);
                              },
                              icon: const Icon(
                                Icons.delete,
                              )):Container(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Obx(() => dbController.dbCateModel.value.category==null
                      ? SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    child: const Center(
                      child:
                      Text("Please Select Any Category To view Quotes"),
                    ),
                  )
                      : dbController.isFromAPIData.value
                      ? dbController.quotesAPIDataList.isNotEmpty
                      ? dbController.quotesAPIDataList[0] !=
                      QuotesAPIModel(
                          author: "Sumit",
                          tags: ["break UP"],
                          content: "Charmi")
                      ? Expanded(
                    child: GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 25,
                          crossAxisSpacing: 25,
                          mainAxisExtent: 100),
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        int style = 0;
                        if (index >= 15) {
                          style = index % 14;
                        } else {
                          style = index;
                        }
                        return InkWell(
                          onTap: () {
                            quotesController.indexAPI.value =
                                index;
                            quotesController.random(1, 21);
                            quotesController
                                .randomFontFamilyGetter(0, 15);
                            familyController.fontManager.value =
                                quotesController.randomFont;
                            Get.toNamed("details",
                                arguments: true);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(20),
                                color:
                                Colors.grey.withOpacity(0.2)),
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  dbController.quotesAPIDataList[index].content!,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: "s$style",
                                      overflow:
                                      TextOverflow.ellipsis),
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  dbController.quotesAPIDataList[index].author!,
                                  style: TextStyle(
                                      fontFamily: "s$style"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: dbController.quotesAPIDataList.length,
                    ),
                  )
                      : const Center(
                    child: Text("Check Your Net work Connection"),
                  )
                      : const Center(
                    child: CircularProgressIndicator(),
                  )
                      : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 25,
                          crossAxisSpacing: 25,
                          mainAxisExtent: 150),
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        int style = 0;
                        if (index >= 15) {
                          style = index % 14;
                        } else {
                          style = index;
                        }
                        return InkWell(
                          onTap: () {
                            quotesController.fIndexJson.value =
                                homeController.indexJson.value;
                            quotesController.lIndexJson.value = index;
                            quotesController.random(1, 21);
                            Get.toNamed("details", arguments: false);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.withOpacity(0.2)),
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  homeController
                                      .jsonModelList[
                                  dbController.indexJsonData.value]
                                      .quotesList![index]
                                      .quote!,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "s$style",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  homeController
                                      .jsonModelList[
                                  dbController.indexJsonData.value]
                                      .quotesList![index]
                                      .author!,
                                  style: TextStyle(fontFamily: "s$style"),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: homeController
                          .jsonModelList[dbController.indexJsonData.value]
                          .quotesList!
                          .length,
                    ),
                  )),
                ],
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
            )));
  }
}
