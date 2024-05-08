import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_db/screen/home/controller/home_controller.dart';
import 'package:quotes_app_db/screen/splash/controller/network_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  NetworkController networkController = Get.put(NetworkController());

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
        ),
        body: Obx(
          () => networkController.isConnected.value
              ? homeController.tagsAPIList.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,mainAxisExtent: 100),
                      itemCount: homeController.tagsAPIList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            homeController.getAPIQuotesList(homeController.tagsAPIList[index].name!);
                            Get.toNamed("quotes",arguments:true);
                          },
                          child: Container(
                            color: homeController.colorList[index].shade400,
                            margin: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                homeController.tagsAPIList[index].name!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
                    return InkWell(
                      onTap: () {
                        homeController.indexJson.value=index;
                        Get.toNamed("quotes",arguments:false);
                      },
                      child: Container(
                        color: homeController.colorList[index].shade400,
                        margin: const EdgeInsets.all(10),
                        height: 100,
                        child: Center(
                          child: Text(
                            homeController.jsonModelList[index].category!,
                            style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: homeController.jsonModelList.length,
                ):Center(child: CircularProgressIndicator(),)
        ),
      ),
    );
  }
}
