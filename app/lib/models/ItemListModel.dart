import 'package:firebase_database/firebase_database.dart';
final databaseReference = FirebaseDatabase.instance.reference();

class ItemList{
  List<ItemDetailListItem> itemList;

  ItemList({this.itemList});

  factory ItemList.fromJSON(Map<dynamic,dynamic> json){
    return ItemList(
        itemList: parseitens(json)
    );
  }

  static List<ItemDetailListItem> parseitens(itemJSON){
    var iList=itemJSON['products'] as List;
    List<ItemDetailListItem> recipeList=iList.map((data) => ItemDetailListItem.fromJson(data)).toList();
    return recipeList;
  }
}


class ItemDetailListItem {
  String itemTitle;
  String iconUrl;
  String value;
  String uid;

  ItemDetailListItem({this.itemTitle,this.iconUrl,this.value,this.uid});

  factory ItemDetailListItem.fromJson(Map<dynamic,dynamic> parsedJson) {
    return ItemDetailListItem(itemTitle:parsedJson['Name'],iconUrl: parsedJson['icon'],value:parsedJson['value'],uid: parsedJson['uid']);
  }
}