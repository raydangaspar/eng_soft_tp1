import 'package:firebase_database/firebase_database.dart';



class Product {
  String id;
  int price;
  String name;
  int quantity;
  String img;


  Product({this.id, this.price, this.name,this.img});

  Product.fromMap(Map snapshot,String id) :
        id = id ?? '',
        price = snapshot['price'] ?? '',
        name = snapshot['name'] ?? '',
        img = snapshot['img'] ?? '';

  toJson() {
    return {
      "price": price,
      "name": name,
      "img": img,
    };
  }
}