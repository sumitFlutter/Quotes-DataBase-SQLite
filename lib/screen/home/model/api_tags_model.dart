class APITagsModel{
  int? count;
  String? name;

  APITagsModel({this.count, this.name});
  factory APITagsModel.mapToModel(Map m1)
  {
    return APITagsModel(count: m1["quoteCount"],name: m1["name"]);
  }
}