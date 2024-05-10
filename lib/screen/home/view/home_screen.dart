import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_db/main.dart';
import 'package:quotes_app_db/screen/database/controller/db_controller.dart';
import 'package:quotes_app_db/screen/database/model/db_category_model.dart';
import 'package:quotes_app_db/screen/home/controller/home_controller.dart';
import 'package:quotes_app_db/screen/splash/controller/network_controller.dart';
import 'package:quotes_app_db/utils/helpers/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  NetworkController networkController = Get.put(NetworkController());
  DBController dbController=Get.put(DBController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getJsonData();
    networkController.first();
    networkController.onChangedConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Quotes Categories"),
          actions: [
            IconButton(
                onPressed: () {
                  themeController.setTheme();
                  homeController.colorList.shuffle();
                },
                icon: Obx(() => Icon(themeController.themeMode.value))),
            PopupMenuButton(itemBuilder: (context) => [
              PopupMenuItem(child: Text("Database"),onTap: () {
                dbController.readQuotes();
                dbController.readCategory();
                Get.toNamed("dataBase");
              },)
            ])
          ],
        ),
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
            Obx(
              () => networkController.isConnected.value
                  ? homeController.tagsAPIList.isNotEmpty
                      ? GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,mainAxisExtent: 100),
                          itemCount: homeController.tagsAPIList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                homeController.quotesAPIModelList.value=[];
                                homeController.getAPIQuotesList(homeController.tagsAPIList[index].name!);
                                homeController.colorList.shuffle();
                                Get.toNamed("quotes",arguments:true);
                              },
                              child: Container(
                                color: homeController.colorList[index].shade400,
                                margin: const EdgeInsets.all(10),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        homeController.tagsAPIList[index].name!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 2,),
                                      IconButton(onPressed: () {
                                        DBCategoryModel d1=DBCategoryModel(index: 1000,category: homeController.tagsAPIList[index].name!);
                                        DBHelper.dbHelper.insertCategory(d1);
                                        dbController.readCategory();
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved SuccessFully")));
                                      }, icon: Icon(Icons.favorite,color: Colors.pinkAccent.shade700,)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                         child: CircularProgressIndicator(),
                        )
                  :homeController.jsonModelList.isNotEmpty? ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ColoredBox(
                            color: homeController.colorList[index].shade400,
                            child: ListTile(
                              onTap: () {
                                homeController.indexJson.value=index;
                                homeController.colorList.shuffle();
                                Get.toNamed("quotes",arguments:false);
                              },
                              title: Text(
                                homeController.jsonModelList[index].category!,
                                style: const TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(onPressed: () {
                                DBCategoryModel d1=DBCategoryModel(index: index,category: homeController.jsonModelList[index].category!);
                                DBHelper.dbHelper.insertCategory(d1);
                                dbController.readCategory();
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved SuccessFully")));
                              }, icon: Icon(Icons.favorite,color: Colors.pinkAccent.shade700,)),
                            ),
                          ),
                        );
                      },
                      itemCount: homeController.jsonModelList.length,
                    ):Center(child: CircularProgressIndicator(),)
            ),
          ],
        ),
      ),
    );
  }
}
