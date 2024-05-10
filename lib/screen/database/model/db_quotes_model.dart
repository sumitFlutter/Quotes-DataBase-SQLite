class DBQuotesModel{
  int? id;
  String? quote,author,category;

  DBQuotesModel({this.id, this.quote, this.author, this.category});
  factory DBQuotesModel.mapToModel(Map m1)
  {
    return DBQuotesModel(author: m1["author"],quote: m1["quote"],category: m1["category"],id: m1["id"]);
  }
}