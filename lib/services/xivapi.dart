import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:FFXIVAuctioneer/models/Category.dart';
import 'dart:convert' as convert;

import 'package:FFXIVAuctioneer/models/FFXIVItem.dart';
import 'package:FFXIVAuctioneer/models/ItemInfos.dart';

class XivApi {
  static String url = "https://xivapi.com";
  static String marketBoard = "/market/ids";
  static String market = "/market/";
  static String item = "item/";
  static String categories = "categories/";
  static String searchItemCategory = "/search?indexes=item&filters=ItemSearchCategory.ID=";

  static dynamic GetSellableItems() async {
    List<FFXIVItem> ffxivItems = <FFXIVItem>[];
    String fUrl = url + marketBoard;

    dynamic responseIds = await http.get(fUrl);

    if (responseIds.statusCode == 200) {
      //on récupère les ids et on boucle issou
      dynamic finalIds = convert.jsonDecode(responseIds.body);

      for (var id in finalIds) {
        //on execue la query
        dynamic currItem =
            await http.get(url + market + "Zodiark" + item + id.toString());
        var js = convert.jsonDecode(currItem.body);
        FFXIVItem itemsInfos = FFXIVItem.fromJson(js);

        ffxivItems.add(itemsInfos);
      }

      return ffxivItems;
    }
  }

  static Future<List<Category>> GetCategoriesList() async {
    List<Category> finalResult = <Category>[];
    String finalUrl = url + market + categories;
    var response = await http.get(finalUrl);

    if (response.statusCode == 200) {
      try {
        var array = convert.jsonDecode(response.body);
        for (var i in array) {
          finalResult.add(Category.fromJson(i));
        }
      } catch (Exception) {}
      await new Future.delayed(Duration(milliseconds: 500));

      return finalResult;
    }
  }

  static Future<List<FFXIVItem>> GetItemsByCategoryID(int id) async {
    List<FFXIVItem> finalResult = <FFXIVItem>[];
    String finalUrl = url + searchItemCategory + id.toString();

    var response = await http.get(finalUrl);

    if (response.statusCode == 200) {
      try {
        var array = convert.jsonDecode(response.body);
        if(array["Pagination"]["PageTotal"] > 1){
          
          for(int i = 0; i < array["Pagination"]["PageTotal"]; i++){

            //Query as much as pages
            var res = await http.get(finalUrl+"&Page="+(i+1).toString());
            if(res.statusCode == 200){
              var json = convert.jsonDecode(res.body);

              for(int y = 0; y < json["Results"].length; y ++ ){
                finalResult.add(FFXIVItem.fromJson(json["Results"][y]));
              }
            }

          }

        }else{
          for (int i = 0; i < array["Results"].length;i++) {
            try{
              finalResult.add(FFXIVItem.fromJson(array["Results"][i]));
            }catch(e){
              print(e);
            }
          }
        }
      } catch (e) {
        print(e);
      }
      await new Future.delayed(Duration(milliseconds:500));

      return finalResult;
    }
  }

  static Future<List<ItemInfos>>GetItemInfos(int id) async {

    List<ItemInfos> itemsInfosList = <ItemInfos>[];

    String fUrl = url+market+item+id.toString()+"?dc=Light";
    print("expected : " + "https://xivapi.com/market/item/"+id.toString()+"?dc=Light"); 
    print("got : " + fUrl);
    var response = await http.get(fUrl);

    if(response.statusCode == 200){

        Map<String, dynamic> responseJson = convert.jsonDecode(response.body);
        //var json = convert.jsonDecode(response.body);
        await new Future.delayed(Duration(milliseconds:500));

        responseJson.forEach((k,v){

          ItemInfos item = ItemInfos.fromJson(v);
          item.currServer = k;
          itemsInfosList.add(item);

        });
        return itemsInfosList;
    }
  }
}
