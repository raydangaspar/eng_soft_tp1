import 'package:app/auth_provider.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'login_screen.dart';
import 'root_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Sistema de gerenciamento de estoque e vendas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        home: RootScreen(),

      ),
    );
  }
}
