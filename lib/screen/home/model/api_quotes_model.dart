class QuotesAPIModel{
  String? author,content;
  List<dynamic>? tags=[];

  QuotesAPIModel({this.author, this.content, this.tags});
  factory QuotesAPIModel.mapToModel(Map m1)
  {
    List <dynamic>l1=m1["tags"];
    return QuotesAPIModel(author: m1["author"],content: m1["content"],tags: l1);
  }
}