import 'package:app/home_screen.dart';
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

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
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
        return HomeScreen(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
  }
}

