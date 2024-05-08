class JsonModel{
  String? category;
  List<QuotesJsonModel>? quotesList=[];

  JsonModel({this.category, this.quotesList});
  factory JsonModel.mapToModel(Map m1)
  {
    List l1=m1["1"];
    return JsonModel(category: m1["category"],quotesList: l1.map((e) => QuotesJsonModel.mapToModel(e)).toList());
  }
}

class QuotesJsonModel {
  String? quote,author;

  QuotesJsonModel({this.quote, this.author});
  factory QuotesJsonModel.mapToModel(Map m1)
  {
    return QuotesJsonModel(author: m1["author"],quote: m1["quote"]);
  }
}