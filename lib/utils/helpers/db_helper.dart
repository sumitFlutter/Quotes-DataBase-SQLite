
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:quotes_app_db/screen/database/model/db_category_model.dart';
import 'package:quotes_app_db/screen/database/model/db_quotes_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper{
  static DBHelper dbHelper= DBHelper._();
  DBHelper._();
  Database? database;
  Future<Database?> checkDB() async {
    if(database!=null)
    {
      return database;
    }
    else{
      var db=await initDB();
      return db;
    }
  }
  Future<Database> initDB() async {
    Directory d1=await getApplicationSupportDirectory();
    String path=d1.path;
    String joinPath=join(path,"quotes.db");
    return openDatabase(joinPath,onCreate: (db, version) {
      db.execute('CREATE TABLE quotes(id INTEGER PRIMARY KEY AUTOINCREMENT,quote TEXT,author TEXT,category TEXT)');
      db.execute("CREATE TABLE cate(id INTEGER PRIMARY KEY AUTOINCREMENT,category TEXT,indexJson INTEGER)");
    },version: 1);
  }
  Future<void> insertQuotes(DBQuotesModel dbQuotesModel) async {
    Database dbi=(await checkDB())!;
    dbi.insert("quotes",{"quote":dbQuotesModel.quote,"author":dbQuotesModel.author,"category":dbQuotesModel.category} );
  }
  Future<List<DBQuotesModel>> readQuotes() async {
    Database dbc=(await checkDB())!;
    List <Map>l1 =await dbc.rawQuery("SELECT * FROM quotes");
    List<DBQuotesModel> c=l1.map((e) => DBQuotesModel.mapToModel(e)).toList();
    return c;
  }
  Future<void> deleteQuotes({required int id}) async {
    Database dbd=(await checkDB())!;
    dbd.delete("quotes",whereArgs: [id],where: "id==?");
  }
  Future<void> insertCategory(DBCategoryModel dbCategoryModel) async {
    Database dbi=(await checkDB())!;
    dbi.insert("cate",{"category":dbCategoryModel.category,"indexJson":dbCategoryModel.index} );
  }
  Future<List<DBCategoryModel>> readCategory() async {
    Database dbc=(await checkDB())!;
    List <Map>l1 =await dbc.rawQuery("SELECT * FROM cate");
    List<DBCategoryModel> c=l1.map((e) => DBCategoryModel.mapToModel(e)).toList();
    return c;
  }
  Future<void> deleteCategory({required int id}) async {
    Database dbd=(await checkDB())!;
    dbd.delete("cate",whereArgs: [id],where: "id==?");
  }

}
