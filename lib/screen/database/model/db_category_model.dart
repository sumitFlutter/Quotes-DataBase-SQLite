class DBCategoryModel{
  int? id,index;
  String? category;

  DBCategoryModel({this.id, this.index, this.category});
  factory DBCategoryModel.mapToModel(Map m1)
  {
    return DBCategoryModel(id: m1["id"],category: m1["category"],index: m1["indexJson"]);
  }
}