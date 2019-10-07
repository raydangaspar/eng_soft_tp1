import 'package:flutter/material.dart';
import 'auth.dart';
import 'login_screen.dart';
import 'root_screen.dart';

import 'login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de gerenciamento de estoque e vendas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: RootScreen(auth: Auth()),

    );
  }
}
