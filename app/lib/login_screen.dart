import 'package:app/auth_provider.dart';
import "package:flutter/material.dart";
import 'auth.dart';

class EmailFieldValidator{
  static String validate(String value){
    return value.isEmpty ? 'O email não pode ser vazio' : null;
  }
}

class PasswordFieldValidator{
  static String validate(String value){
    return value.isEmpty ? 'A senha não pode ser vazia' : null;
  }
}

enum FormType {
  login,
  register
}

class LoginScreen extends StatefulWidget {
  LoginScreen({this.onSignedIn});
  final VoidCallback onSignedIn;

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
        var auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          String userId = await auth.signInWithEmailAndPassword(_email, _password);
//          print('Signed in: $userId');
          }
        else {
          String userId = await auth.createUserWithEmailAndPassword(_email, _password);
//          print('Usuário registrado: $userId');
        }
        widget.onSignedIn();
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
          title: Text('Entre com a sua conta'),
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
        key: Key('email'),
        decoration: InputDecoration(labelText: 'Email'),
        validator: EmailFieldValidator.validate,
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        key: Key('password'),
        decoration: InputDecoration(labelText: 'Senha'),
        validator: PasswordFieldValidator.validate,
        onSaved: (value) => _password = value,
        obscureText: true,
      ),

    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          key: Key('SignIn'),
          child: Text('Login', style: TextStyle(fontSize: 20)),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          key: Key('SignUp'),
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