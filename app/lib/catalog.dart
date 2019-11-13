import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// TODO: Botar esse trem no firebase
class CatalogModel {
  static const _itemNames = [
    'Caixa de Som',
    'Monitor',
    'Teclado',
    'Mouse',
    'Processador',
    'Memoria Ram',
    'Placa de Video',
    'Fan',
    'Fita Led',
    'Cadeira',
    'Placa de rede',
    'Fonte',
    'Gabinete',
    'Fone',
  ];

  /// In this sample, the catalog is infinite, looping over [_itemNames].
  Item getById(int id) => Item(id, _itemNames[id % _itemNames.length]);

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}
  // GAMBIARAITOR
@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  Item(this.id, this.name)
      // To make the sample app look nicer, each item is given one of the
      // Material Design primary colors.
      : color = Colors.primaries[id % Colors.primaries.length];
  

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}

@immutable
class Record {
  final int id;
  final String name;
  final String url;
  final int quantity;
  final int price;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : id = map['id'],
        name = map['name'],
        url = map['url'],
        price = map['price'],
        quantity = map['quantity'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$price>";

}