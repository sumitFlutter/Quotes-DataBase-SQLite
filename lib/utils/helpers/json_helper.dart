import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quotes_app_db/screen/home/model/json_model.dart';

class JsonHelper{
  static JsonHelper jsonHelper=JsonHelper._();
  JsonHelper._();
  Future<List<JsonModel>> getData()
  async {
    String jsonString=await rootBundle.loadString("assets/json/quotes.json");
    List jsonList =jsonDecode(jsonString);
    List <JsonModel> quotesList=jsonList.map((e) => JsonModel.mapToModel(e)).toList();
    return quotesList;
  }
}