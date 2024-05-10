import 'package:get/get.dart';
import 'package:quotes_app_db/utils/helpers/db_helper.dart';

import '../model/db_category_model.dart';
import '../model/db_quotes_model.dart';

class DBController extends GetxController{
  RxList<DBQuotesModel> dbQuotesModelList=<DBQuotesModel>[].obs;
  RxList<DBCategoryModel> dbCategoryModelList=<DBCategoryModel>[].obs;
  Future<void> readQuotes()
  async {
    dbQuotesModelList.value=await DBHelper.dbHelper.readQuotes();
  }
  void readCategory()
  async {
    dbCategoryModelList.value=await DBHelper.dbHelper.readCategory();
  }
}