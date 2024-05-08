
/*class DBHelper{
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
    String joinPath=join(path,"gemini.db");
    return openDatabase(joinPath,onCreate: (db, version) {
      db.execute('CREATE TABLE quotes(id INTEGER PRIMARY KEY,quote TEXT,author TEXT,category TEXT)');
    },version: 1);
  }
  Future<void> insertQuotes(GeminiDBModel geminiDBModel) async {
    Database dbi=(await checkDB())!;
    dbi.insert("quotes",{"quote":geminiDBModel.text,"author":geminiDBModel.date,"category":geminiDBModel.time} );
  }
  Future<List<GeminiDBModel>> readQuotes() async {
    Database dbc=(await checkDB())!;
    List <Map>l1 =await dbc.rawQuery("SELECT * FROM quotes");
    List<GeminiDBModel> c=l1.map((e) => GeminiDBModel.mapToModel(e)).toList();
    return c;
  }
  Future<void> deleteQuotes({required int id}) async {
    Database dbd=(await checkDB())!;
    dbd.delete("quotes",whereArgs: [id],where: "id==?");
  }

}
*/