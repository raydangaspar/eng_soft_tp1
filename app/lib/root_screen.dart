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
            auth: widget.adsdasd
      case AuthStatus.signedIn:
        return HomeScreen(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
  }
}


import 'package:app/cart_screen.dart';
import 'package:app/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/cart.dart';
import 'package:app/catalog.dart';
import 'package:app/catalog_screen.dart';
import 'package:app/theme.dart';

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
        return MultiProvider(
          providers: [
            // In this sample app, CatalogModel never changes, so a simple Provider
            // is sufficient.
            Provider(builder: (context) => CatalogModel()),
            // CartModel is implemented as a ChangeNotifier, which calls for the use
            // of ChangeNotifierProvider. Moreover, CartModel depends
            // on CatalogModel, so a ProxyProvider is needed.
            ChangeNotifierProxyProvider<CatalogModel, CartModel>(
                builder: (context, catalog, previousCart) =>
                    CartModel(catalog, previousCart)),
          ],
          child: MaterialApp(
            title: 'Provider Demo',
            theme: appTheme,
            initialRoute: '/',
            routes: {
              '/': (context) => MyCatalog(),
              '/cart': (context) => MyCart(),
            },
          ),
        );
    }
  }
}

