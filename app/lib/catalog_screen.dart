import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/cart.dart';

import 'package:app/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'catalog.dart';

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
            SizedBox(width: 25),
            Expanded(
              child: Text(record.name),
            ),

            SizedBox(width: 20),
            Expanded(
              child: Text("R\$" + record.price.toString()),
            ),

            SizedBox(),
            AddRmvButton(item: record,)
          ],
        ),
      ),
    );
  }


}

class AddRmvButton extends StatelessWidget {
  final Record item;

  const AddRmvButton({Key key, @required this.item}) : super(key: key);

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