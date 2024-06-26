import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app_db/screen/home/model/api_quotes_model.dart';
import 'package:quotes_app_db/screen/home/model/api_tags_model.dart';
import 'package:quotes_app_db/utils/helpers/api_helper.dart';
import 'package:quotes_app_db/utils/helpers/json_helper.dart';

import '../model/json_model.dart';

class HomeController extends GetxController{
  RxList<JsonModel> jsonModelList=<JsonModel>[].obs;
  RxList<APITagsModel> tagsAPIList=<APITagsModel>[].obs;
  RxInt indexJson=(-1).obs;
  RxString tagOfAPI="".obs;
  RxList<QuotesAPIModel> quotesAPIModelList=<QuotesAPIModel>[].obs;
  RxBool isFromAPI=false.obs;
  void getJsonData()
  async {
    jsonModelList.value=await JsonHelper.jsonHelper.getData();
  }
  Future<void> getAPIQuotesList(String tag)
  async {
      quotesAPIModelList.value=[];
    tagOfAPI.value=tag;
       quotesAPIModelList.value=(await APIHelper.apiHelper.quotesAPICalling(tag));
  }
}