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
        if (_formType == FormType.login) {
          FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
          print('Signed in: ${user.uid}');
          }
        else {
          FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
          print('Usuário registrado: ${user.uid}');
        }
      }
      catch (e) {
        print('Error: $e');
      }

    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });

  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Login'),
      ),
      body: Container(

        padding: EdgeInsets.all(16),

        child: Form(
          key: formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButtons(),
          ),

        )
      )
    );
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? 'O email não pode ser vazio' : null,
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Senha'),
        validator: (value) => value.isEmpty ? 'A senha não pode ser vazia' : null,
        onSaved: (value) => _password = value,
        obscureText: true,
      ),

    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          child: Text('Login', style: TextStyle(fontSize: 20)),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text('Criar uma conta', style: TextStyle(fontSize: 20)),
          onPressed: moveToRegister,
        )
      ];
    }
    else {
      return [
        RaisedButton(
          child: Text('Cadastrar', style: TextStyle(fontSize: 20)),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text('Já tem uma conta? Fazer login', style: TextStyle(fontSize: 20)),
          onPressed: moveToLogin,
        )
      ];
    }
  }

}