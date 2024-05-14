import 'package:get/get.dart';
import 'package:quotes_app_db/screen/home/model/api_quotes_model.dart';
import 'package:quotes_app_db/utils/helpers/db_helper.dart';

import '../../../utils/helpers/api_helper.dart';
import '../model/db_category_model.dart';
import '../model/db_quotes_model.dart';

class DBController extends GetxController{
  RxList<DBQuotesModel> dbQuotesModelList=<DBQuotesModel>[].obs;
  RxList<DBCategoryModel> dbCategoryModelList=<DBCategoryModel>[].obs;
  RxInt indexJsonData=(-1).obs;
  RxList<QuotesAPIModel> quotesAPIDataList=<QuotesAPIModel>[].obs;
  RxBool isFromAPIData=false.obs;
  Rx<DBCategoryModel> dbCateModel=DBCategoryModel().obs;
  Future<void> readQuotes()
  async {
    dbQuotesModelList.value=await DBHelper.dbHelper.readQuotes();
  }
  void readCategory()
  async {
    dbCategoryModelList.value=await DBHelper.dbHelper.readCategory();
  }
  Future<void> getAPIQuotesList(String tag)
  async {
    quotesAPIDataList.value=[];
    quotesAPIDataList.value=(await APIHelper.apiHelper.quotesAPICalling(tag));
  }
}