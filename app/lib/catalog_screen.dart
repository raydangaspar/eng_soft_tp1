import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/cart.dart';
import 'package:app/catalog.dart';

import 'package:app/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyCatalog extends StatelessWidget {
  MyCatalog({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try{
      await auth.signOut();
      onSignedOut();
    }
    catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Catalogo de Produtos', style: Theme.of(context).textTheme.display4),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            ),
            FlatButton(
                child: Text('Logout', style: TextStyle(fontSize: 17, color: Colors.white)),
                onPressed: _signOut
            )
          ],
        ),
        body: _buildBody(context),
      );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            SizedBox(width: 24),
            Expanded(
              child: Text(record.name),
            ),

            SizedBox(width: 10),
            Expanded(
              child: Text(record.price.toString()),
            ),

            //SizedBox(),
            //_AddButton(item: item),

            SizedBox(),
            _Add_Rmv_Button(item: record,)
          ],
        ),
      ),
    );
  }


}

class _Add_Rmv_Button extends StatelessWidget {
  final Record item;

  const _Add_Rmv_Button({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

  if (cart.items.contains(item) ) {
      return FlatButton(
      onPressed: cart.items.contains(item) ? () => cart.rmv(item) : null ,
      splashColor: Theme.of(context).primaryColor,
      child: cart.items.contains(item)
          ? Icon(Icons.delete_forever, semanticLabel: 'RMVED')
          : Text('RMV'),
    );
  } else {
      return FlatButton(
      onPressed: cart.items.contains(item) ? null : () => cart.add(item),
      splashColor: Theme.of(context).primaryColor,
      child: cart.items.contains(item)
          ? Text('ADD')
          : Icon(Icons.control_point, semanticLabel: 'ADDED'),
    );
  }

  }
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

//class _MyListItem extends StatelessWidget {
//  final int index;
//
//  _MyListItem(this.index, {Key key}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//
//    var catalog = Provider.of<CatalogModel>(context);
//    var item = catalog.getByPosition(index);
//    var textTheme = Theme.of(context).textTheme.title;
//
//    var stream = Firestore.instance.collection('products').snapshots();
//
//    return Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//      child: LimitedBox(
//        maxHeight: 48,
//        child: Row(
//          children: [
//            AspectRatio(
//              aspectRatio: 1,
//              child: Container(
//                color: item.color,
//              ),
//            ),
//            SizedBox(width: 24),
//            Expanded(
//              child: Text(item.name, style: textTheme),
//            ),
//
//            SizedBox(width: 10),
//            Expanded(
//              child: Text(item.price.toString()),
//            ),
//
//            //SizedBox(),
//            //_AddButton(item: item),
//
//             SizedBox(),
//            _Add_Rmv_Button(item: item,)
//          ],
//        ),
//      ),
//    );
//  }
//}