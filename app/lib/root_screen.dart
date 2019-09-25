import 'package:app/login_screen.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class RootScreen extends StatefulWidget{
  RootScreen({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() {
    return _RootScreenState();
  }
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _RootScreenState extends State<RootScreen> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LoginScreen(
            auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return Scaffold(
          body: Container(
            padding: EdgeInsets.all(20),
            child: Text('Bem-Vindo! \n\n Limpe o cache do app para fazer logout', style: TextStyle(fontSize: 70)),
          ),
        );
    }
  }
}

