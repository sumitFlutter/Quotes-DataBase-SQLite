import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:quotes_app_db/screen/database/controller/db_controller.dart';
import 'package:quotes_app_db/screen/home/controller/home_controller.dart';
import 'package:quotes_app_db/utils/helpers/api_helper.dart';

class NetworkController extends GetxController{
  RxBool isConnected=false.obs;
  void first()
  async {
    ConnectivityResult firstTime = await Connectivity().checkConnectivity();
    if(firstTime==ConnectivityResult.none)
    {
      isConnected.value=false;
    }
    else {
      isConnected.value = true;
      Get.find<HomeController>().isFromAPI.value=true;
      Get.find<DBController>().isFromAPIData.value=true;
      Get.find<HomeController>().tagsAPIList.value=(await APIHelper.apiHelper.getTags())!;
    }
  }
  void onChangedConnectivity()
  {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if(result==ConnectivityResult.none)
      {
        isConnected.value=false;
        Get.find<HomeController>().isFromAPI.value=false;
        Get.find<DBController>().isFromAPIData.value=false;
        Get.find<DBController>().quotesAPIDataList.value=[];
        Get.find<DBController>().indexJsonData.value=-1;
        Get.find<HomeController>().indexJson.value=-1;
        Get.find<HomeController>().tagOfAPI.value="";
      }
      else{
        isConnected.value=true;
        if(Get.find<HomeController>().tagsAPIList.isEmpty)
          {
            Get.find<HomeController>().tagsAPIList.value=(await APIHelper.apiHelper.getTags())!;
          }
        Get.find<HomeController>().isFromAPI.value=true;
        Get.find<DBController>().isFromAPIData.value=true;
        Get.find<DBController>().quotesAPIDataList.value=[];
        Get.find<DBController>().indexJsonData.value=-1;
        Get.find<HomeController>().indexJson.value=-1;
        Get.find<HomeController>().tagOfAPI.value="";
      }
    });


  }
}