import 'package:app/auth.dart';
import 'package:app/auth_provider.dart';
import 'package:app/login_screen.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";

class MockAuth extends Mock implements BaseAuth {}


void main() {
  group("Preenchimento do login", () {
    test("Email vazio retorna erro", () {
      var result = EmailFieldValidator.validate('');
      expect(result, 'O email não pode ser vazio');
    });

    test("Email não vazio retorna null", () {
      var result = EmailFieldValidator.validate('teste@teste.com');
      expect(result, null);
    });

    test("Senha vazia retorna erro", () {
      var result = PasswordFieldValidator.validate('');
      expect(result, 'A senha não pode ser vazia');
    });

    test("Senha não vazia retorna null", () {
      var result = PasswordFieldValidator.validate('111111');
      expect(result, null);
    });
  });

  group("Autenticação", () {
    Widget makeTestableWidget({Widget child, BaseAuth auth})  {
      return AuthProvider (
        auth: auth,
        child: MaterialApp(
          home: child,
        ),
      );
    }

    testWidgets("Usuário aperta botao de login sem preencher email e senha válidos, processo de signIn não executa", (WidgetTester tester) async {
      MockAuth mockAuth = MockAuth();
      bool didSignIn = false;

      LoginScreen page = LoginScreen(onSignedIn: () => didSignIn = true);
      await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

      await tester.tap(find.byKey(Key('SignIn')));

      verifyNever(mockAuth.signInWithEmailAndPassword('', ''));
      expect(didSignIn, false);
    });

    testWidgets("Usuário aperta botao de login após preencher email e senha válidos, processo de signIn executa normalmente", (WidgetTester tester) async {
      MockAuth mockAuth = MockAuth();
      bool didSignIn = false;

      LoginScreen page = LoginScreen(onSignedIn: () => didSignIn = true);
      await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));

      Finder emailFinder = find.byKey(Key('email'));
      await tester.enterText(emailFinder, "teste@teste.com");
      Finder passwordFinder = find.byKey(Key('password'));
      await tester.enterText(passwordFinder, "111111");

      await tester.tap(find.byKey(Key('SignIn')));

      verify(mockAuth.signInWithEmailAndPassword('teste@teste.com', '111111')).called(1);
      expect(didSignIn, true);
    });
  });

  group("Funcionalidades da interface (Widgets)", (){
    testWidgets("Função de logout não aparece ao se abrir o app pela primeira vez", (WidgetTester tester) async {
      await tester.pumpWidget(new MyApp());
      expect(find.text("Logout"), findsNothing);
    });

    testWidgets("Garantia de que existem dois campos de texto e que são os de email e senha", (WidgetTester tester) async {
      await tester.pumpWidget(new MyApp());
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byKey(Key('email')), findsOneWidget);
      expect(find.byKey(Key('password')), findsOneWidget);
    });

    testWidgets("Garantia de que os botoes de Login e cadastro existem", (WidgetTester tester) async {
      await tester.pumpWidget(new MyApp());
      expect(find.widgetWithText(RaisedButton, "Login"), findsOneWidget);
      expect(find.widgetWithText(FlatButton, "Criar uma conta"), findsOneWidget);
    });
  });
}