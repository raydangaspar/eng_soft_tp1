import 'package:app/showcase_screen.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

enum FormType {
  login,
  register
}

class LoginScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }

}

class _LoginScreenState extends State<LoginScreen>{

  final formKey = GlobalKey<FormState>();

  String _email, _password;

  FormType _formType = FormType.login;

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)) as FirebaseUser;
        print('Signed in: ${user.uid}');
      }
      catch (e) {
        print('Error: $e');
      }

    }
  }

  void moveToRegister() {
//    setState(() {
//      _formType = FormType.register;
//    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Showcase()),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Faça seu login'),
      ),
      body: Container(

        padding: EdgeInsets.all(16),

        child: Form(
          key: formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                onSaved: (value) => _password = value,
                obscureText: true,
              ),
              RaisedButton(
                child: Text('Login', style: TextStyle(fontSize: 20)),
                onPressed: validateAndSubmit,
              ),
              RaisedButton(
                child: Text('Criar uma conta', style: TextStyle(fontSize: 20)),
                onPressed: moveToRegister,
              )
            ],
          ),

        )
      )
    );
  }

}