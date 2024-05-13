import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../utils/helpers/db_helper.dart';
import '../../details/controller/font_family_controller.dart';
import '../../home/controller/home_controller.dart';
import '../../home/model/api_quotes_model.dart';
import '../../home/model/api_tags_model.dart';
import '../../quotes/controller/quotes_controller.dart';
import '../../splash/controller/network_controller.dart';
import '../controller/db_controller.dart';
import '../model/db_category_model.dart';
import '../model/db_quotes_model.dart';

class DBQuotesViewScreen extends StatefulWidget {
  const DBQuotesViewScreen({super.key});

  @override
  State<DBQuotesViewScreen> createState() => _DBQuotesViewScreenState();
}

class _DBQuotesViewScreenState extends State<DBQuotesViewScreen> {
  DBController dbController=Get.put(DBController());
  HomeController homeController=Get.put(HomeController());
  NetworkController networkController = Get.put(NetworkController());
  QuotesController quotesController = Get.put(QuotesController());
  FontFamilyController familyController=Get.put(FontFamilyController());

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(() => networkController.isConnected.value
                  ? Obx(
                    () =>  SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.08,
                  child: homeController.tagsAPIList.isNotEmpty
                      ? homeController.tagsAPIList[0] !=
                      APITagsModel(name: "sumit", count: 0)
                      ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          homeController.getAPIQuotesList(
                              homeController
                                  .tagsAPIList[index].name!);
                          homeController.isFromAPI.value=true;
                        },
                        child: Obx(
                              () => Container(
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: themeController.pTheme.value
                                  ? homeController.tagOfAPI.value==homeController
                                  .tagsAPIList[index].name!?Colors.black54:Colors.grey.shade100
                                  : homeController.tagOfAPI.value==homeController
                                  .tagsAPIList[index].name!?Colors.green.shade300:Colors.black,
                            ),
                            margin: EdgeInsets.all(12),
                            child: Center(
                              child: Text(
                                homeController
                                    .tagsAPIList[index].name!,
                                style: TextStyle(color: themeController.pTheme.value
                                    ? homeController.tagOfAPI.value==homeController
                                    .tagsAPIList[index].name!?Colors.white:Colors.black
                                    : homeController.tagOfAPI.value==homeController
                                    .tagsAPIList[index].name!?Colors.black:Colors.white,),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: homeController.tagsAPIList.length,
                  )
                      : Center(
                    child: Text("Check Your Net work Connection"),
                  )
                      : Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
                  : Obx(
                      () => SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.08,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            homeController.indexJson.value=index;
                            quotesController.randomFontFamilyGetter(0, 15);
                            familyController.fontManager.value=quotesController.randomFont;
                            homeController.isFromAPI.value=false;
                          },
                          child: Obx(
                                () => Container(
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: themeController.pTheme.value
                                    ? homeController.indexJson.value==index?Colors.black54:Colors.grey.shade100
                                    : homeController.indexJson.value==index?Colors.green.shade300:Colors.black,
                              ),
                              margin: EdgeInsets.all(12),
                              child: Center(
                                child: Text(
                                  homeController.jsonModelList[index].category!,
                                  style: TextStyle(color: themeController.pTheme.value
                                      ? homeController.indexJson.value==index?Colors.white:Colors.black
                                      : homeController.indexJson.value==index?Colors.black:Colors.white,),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: homeController.jsonModelList.length,
                    ),
                  )),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.all(4),
                child: Obx(
                      () => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      homeController.indexJson.value==-1&&homeController.tagOfAPI.value==""?
                      Text("Select Category"):
                      homeController.isFromAPI.value?Text(homeController.tagOfAPI.value):
                      Text(homeController.jsonModelList[homeController.indexJson.value].category!),
                      IconButton(onPressed: () {
                        if(homeController.indexJson.value!=-1&&homeController.tagOfAPI.value!="")
                        {
                          if(homeController.isFromAPI.value)
                          {
                            DBCategoryModel c1=DBCategoryModel(category: homeController.tagOfAPI.value,index: 1000);
                            DBHelper.dbHelper.insertCategory(c1);
                            dbController.readCategory();
                          }
                          else{
                            DBCategoryModel c1=DBCategoryModel(category: homeController.jsonModelList[homeController.indexJson.value].category!,index: homeController.indexJson.value);
                            DBHelper.dbHelper.insertCategory(c1);
                            dbController.readCategory();
                          }
                        }
                      }, icon: Icon(Icons.thumb_up,))
                    ],),
                ),
              ),
              Obx(() =>homeController.indexJson.value==-1&&homeController.tagOfAPI.value==""?
              SizedBox(height: MediaQuery.sizeOf(context).height*0.5,
                child: Center(child: Text("Please Select Any Category To view Quotes"),),):
              homeController.isFromAPI.value?
              homeController.quotesAPIModelList.isNotEmpty?
              homeController.quotesAPIModelList[0]!=QuotesAPIModel(author: "Sumit",tags: ["break UP"],content: "Charmi")?
              Expanded(
                child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 25,crossAxisSpacing: 25), padding:EdgeInsets.all(10), itemBuilder: (context, index) {
                  int style=0;
                  if(index>=15)
                  {
                    style=index%14;
                  }
                  else{
                    style=index;
                  }
                  return InkWell(
                    onTap: () {
                      quotesController.indexAPI.value=index;
                      quotesController.random(1, 21);
                      quotesController.randomFontFamilyGetter(0, 15);
                      familyController.fontManager.value=quotesController.randomFont;
                      Get.toNamed("details",arguments: true);
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey.withOpacity(0.2)),
                      padding: EdgeInsets.all(4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(alignment: Alignment.centerRight,child: IconButton(icon: Icon(Icons.favorite_border),onPressed: () {
                            DBQuotesModel db=DBQuotesModel(author: homeController.quotesAPIModelList[index].author!,quote: homeController.quotesAPIModelList[index].content!,category: homeController.tagOfAPI.value);
                            DBHelper.dbHelper.insertQuotes(db);
                            dbController.readQuotes();
                          },),),
                          SizedBox(height: 10,),
                          Text(homeController.quotesAPIModelList[index].content!,style: TextStyle(fontSize: 10,fontFamily: "s$style"),),
                          SizedBox(height: 1,),
                          Text(homeController.quotesAPIModelList[index].author!,style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  );
                },
                  itemCount: homeController.quotesAPIModelList.length,),
              ): const Center(
                child: Text("Check Your Net work Connection"),
              )
                  : const Center(
                child: CircularProgressIndicator(),
              ):
              Expanded(
                child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing:25,crossAxisSpacing: 25), padding:EdgeInsets.all(10),itemBuilder: (context, index) {
                  int style=0;
                  if(index>=15)
                  {
                    style=index%14;
                  }
                  else{
                    style=index;
                  }
                  return InkWell(
                    onTap: () {
                      quotesController.fIndexJson.value=homeController.indexJson.value;
                      quotesController.lIndexJson.value=index;
                      quotesController.random(1, 21);
                      Get.toNamed("details",arguments: false);
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey.withOpacity(0.2)),
                      padding: EdgeInsets.all(4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(alignment: Alignment.centerRight,child: IconButton(icon: Icon(Icons.favorite_border),onPressed: () {
                            DBQuotesModel db=DBQuotesModel(author: homeController.jsonModelList[homeController.indexJson.value].quotesList![index].author!,quote: homeController.jsonModelList[homeController.indexJson.value].quotesList![index].quote!,category: homeController.jsonModelList[homeController.indexJson.value].category!);
                            DBHelper.dbHelper.insertQuotes(db);
                            dbController.readQuotes();
                          },),),
                          SizedBox(height: 10,),
                          Text(homeController.jsonModelList[homeController.indexJson.value].quotesList![index].quote!,style: TextStyle(fontSize: 10,fontFamily: "s$style"),),
                          SizedBox(height: 1,),
                          Text(homeController.jsonModelList[homeController.indexJson.value].quotesList![index].author!)
                        ],
                      ),
                    ),
                  );
                },
                  itemCount: homeController.jsonModelList[homeController.indexJson.value].quotesList!.length,),
              )
              ),
            ],
          ),
    );
  }
}
/*
SizedBox(height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Obx(
              () => ListView.builder(
                          itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(dbController.dbQuotesModelList[index].quote!,style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text("${dbController.dbQuotesModelList[index].author!}\n(${dbController.dbQuotesModelList[index].category!})",style: TextStyle(fontWeight: FontWeight.bold,),),
                  trailing: IconButton(onPressed: () {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text("Are you sure?"),
                        actions: [
                          ElevatedButton(onPressed: () {
                            Navigator.pop(context);
                          }, child: Text("No!")),
                          ElevatedButton(onPressed: () {
                            DBHelper.dbHelper.deleteQuotes(id: dbController.dbQuotesModelList[index].id!);
                            dbController.readQuotes();
                            Navigator.pop(context);
                          }, child: Text("Yes!"))
                        ],
                      );
                    },);
                  }, icon: Icon(Icons.delete,)),
                ),
              );
                          },itemCount: dbController.dbQuotesModelList.length,),
            ),
          );
 */
