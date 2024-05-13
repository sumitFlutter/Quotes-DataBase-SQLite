/*
https://api.quotable.io/tags
https://api.quotable.io/quotes/random?limit=40&tags=love*/
import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:quotes_app_db/screen/home/model/api_quotes_model.dart';
import 'package:quotes_app_db/screen/home/model/api_tags_model.dart';
class APIHelper{
  static APIHelper apiHelper =APIHelper._();
  APIHelper._();
  Future<List<QuotesAPIModel>> quotesAPICalling(String tag)
  async {
    var result=await http.get(Uri.parse("https://api.quotable.io/quotes/random?limit=40&tags=$tag"));
    if(result.statusCode==200)
      {
        List l1=jsonDecode(result.body);
        List<QuotesAPIModel>quotesAPIList=l1.map((e) => QuotesAPIModel.mapToModel(e)).toList();
        return quotesAPIList;
      }
    else{
      return <QuotesAPIModel>[QuotesAPIModel(author: "Sumit",tags: ["break UP"],content: "Charmi")];
    }
  }
  Future<List<APITagsModel>> getTags()
  async {
    var result=await http.get(Uri.parse("https://api.quotable.io/tags"));
    if(result.statusCode==200)
      {
        List l1=jsonDecode(result.body);
        List<APITagsModel> apiTags=l1.map((e) => APITagsModel.mapToModel(e)).toList();
        List<APITagsModel>apiListTags=[];
        for(var x in apiTags)
          {
            if(x.count!=0)
              {
                apiListTags.add(x);
              }
          }
        return apiListTags;
      }
    else{
      return <APITagsModel>[APITagsModel(name: "sumit",count: 0)];
    }
  }
}