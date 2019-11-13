import 'package:app/auth.dart';
import 'package:app/auth_provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({this.onSignedOut});
  final VoidCallback onSignedOut;

  void _signOut(BuildContext context  ) async {
    try{
      var auth = AuthProvider.of(context).auth;
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
        title: Text('Home'),
        actions: <Widget>[
          FlatButton(
            child: Text('Logout', style: TextStyle(fontSize: 17, color: Colors.white)),
            onPressed: () => _signOut(context)
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Text('Tela inicial', style: TextStyle(fontSize: 32.0))
        ),
      ),
    );
  }

}