import 'package:flutter_test/flutter_test.dart';
import 'package:app/catalog.dart' as cat;
import 'package:app/cart.dart' as cart;

void main() {

  //BEGIN: Testes de catalog.dart 
  test('record está comportando corretamente', () {
    var produto = {
      "id": 123,
      "name": 'teclado',
      "url": "null",
      "price": 100,
      "quantity": 3,
    };

    final rec_test = cat.Record.fromMap(produto);
    
    expect(rec_test.name, 'teclado');
    expect(rec_test.price, 100);
    expect(rec_test.quantity, 3);
    expect(rec_test.url, 'null');
  });

  test('insere produto na lista do catalogo', () {
    var produto = {
      "id": 123,
      "name": 'teclado',
      "url": "null",
      "price": 100,
      "quantity": 3,
    };

    final rec_test = cat.Record.fromMap(produto);
    final catalog_test = cat.CatalogModel();

    catalog_test.insertItemOnItemsList(rec_test);
    
    expect(catalog_test.getById(123).name, 'teclado');
    expect(catalog_test.getById(123).price, 100);
    expect(catalog_test.getById(123).quantity, 3);
    expect(catalog_test.getById(123).url, 'null');
  });

  test('insere varios produtos na lista do catalogo', () {
    var produto = {
      "id": 123,
      "name": 'teclado',
      "url": "null",
      "price": 100,
      "quantity": 3,
    };
    var produto2 = {
      "id": 124,
      "name": 'mouse',
      "url": "null",
      "price": 150,
      "quantity": 1,
    };
    var produto3 = {
      "id": 125,
      "name": 'tela',
      "url": "null",
      "price": 400,
      "quantity": 4,
    };

    final rec_test = cat.Record.fromMap(produto);
    final rec_test2 = cat.Record.fromMap(produto2);
    final rec_test3 = cat.Record.fromMap(produto3);
    final catalog_test = cat.CatalogModel();

    catalog_test.insertItemOnItemsList(rec_test);
    catalog_test.insertItemOnItemsList(rec_test2);
    catalog_test.insertItemOnItemsList(rec_test3);
    
    expect(catalog_test.getById(123).name, 'teclado');
    expect(catalog_test.getById(123).price, 100);
    expect(catalog_test.getById(123).quantity, 3);
    expect(catalog_test.getById(123).url, 'null');

    expect(catalog_test.getById(124).name, 'mouse');
    expect(catalog_test.getById(124).price, 150);
    expect(catalog_test.getById(124).quantity, 1);
    expect(catalog_test.getById(124).url, 'null');

    expect(catalog_test.getById(125).name, 'tela');
    expect(catalog_test.getById(125).price, 400);
    expect(catalog_test.getById(125).quantity, 4);
    expect(catalog_test.getById(125).url, 'null');
  });
  //End: Testes de catalog.dart

  //Begin: Testes de card.dart
  test('add produto do catalogo no carrinho', () {
    var produto = {
      "id": 123,
      "name": 'teclado',
      "url": "null",
      "price": 100,
      "quantity": 3,
    };
    final rec_test = cat.Record.fromMap(produto);
    final catalog_test = cat.CatalogModel();
    final cart_test = cart.CartModel(catalog_test, null );

    cart_test.addItemToCatalogItemsList(rec_test);
    cart_test.add(rec_test);

    expect(cart_test.items.length, 1);
  });

  test('add multiplos produtos do catalogo no carrinho', () {
    var produto = {
      "id": 123,
      "name": 'teclado',
      "url": "null",
      "price": 100,
      "quantity": 3,
    };
    var produto2 = {
      "id": 124,
      "name": 'mouse',
      "url": "null",
      "price": 150,
      "quantity": 1,
    };
    var produto3 = {
      "id": 125,
      "name": 'tela',
      "url": "null",
      "price": 400,
      "quantity": 4,
    };

    final rec_test = cat.Record.fromMap(produto);
    final rec_test2 = cat.Record.fromMap(produto2);
    final rec_test3 = cat.Record.fromMap(produto3);
    final catalog_test = cat.CatalogModel();

    final cart_test = cart.CartModel(catalog_test, null );

    cart_test.addItemToCatalogItemsList(rec_test);
    cart_test.addItemToCatalogItemsList(rec_test2);
    cart_test.addItemToCatalogItemsList(rec_test3);

    cart_test.add(rec_test);
    cart_test.add(rec_test2);
    cart_test.add(rec_test3);

    expect(cart_test.items.length, 3);
  });

  test('remove produtos do carrinho', () {
    var produto = {
      "id": 123,
      "name": 'teclado',
      "url": "null",
      "price": 100,
      "quantity": 3,
    };
    var produto2 = {
      "id": 124,
      "name": 'mouse',
      "url": "null",
      "price": 150,
      "quantity": 1,
    };
    var produto3 = {
      "id": 125,
      "name": 'tela',
      "url": "null",
      "price": 400,
      "quantity": 4,
    };

    final rec_test = cat.Record.fromMap(produto);
    final rec_test2 = cat.Record.fromMap(produto2);
    final rec_test3 = cat.Record.fromMap(produto3);
    final catalog_test = cat.CatalogModel();

    final cart_test = cart.CartModel(catalog_test, null );

    cart_test.addItemToCatalogItemsList(rec_test);
    cart_test.addItemToCatalogItemsList(rec_test2);
    cart_test.addItemToCatalogItemsList(rec_test3);

    cart_test.add(rec_test);
    cart_test.add(rec_test2);
    cart_test.add(rec_test3);

    cart_test.rmv(rec_test);
    cart_test.rmv(rec_test2);

    expect(cart_test.items.length, 1);
  });

  test('remove todos os produtos do carrinho', () {
    var produto = {
      "id": 123,
      "name": 'teclado',
      "url": "null",
      "price": 100,
      "quantity": 3,
    };
    var produto2 = {
      "id": 124,
      "name": 'mouse',
      "url": "null",
      "price": 150,
      "quantity": 1,
    };
    var produto3 = {
      "id": 125,
      "name": 'tela',
      "url": "null",
      "price": 400,
      "quantity": 4,
    };

    final rec_test = cat.Record.fromMap(produto);
    final rec_test2 = cat.Record.fromMap(produto2);
    final rec_test3 = cat.Record.fromMap(produto3);
    final catalog_test = cat.CatalogModel();

    final cart_test = cart.CartModel(catalog_test, null );

    cart_test.addItemToCatalogItemsList(rec_test);
    cart_test.addItemToCatalogItemsList(rec_test2);
    cart_test.addItemToCatalogItemsList(rec_test3);

    cart_test.add(rec_test);
    cart_test.add(rec_test2);
    cart_test.add(rec_test3);

    cart_test.rmv(rec_test);
    cart_test.rmv(rec_test2);
    cart_test.rmv(rec_test3);

    expect(cart_test.items.length, 0);
  });

  test('verifica os produtos no carrinho (sem remoção)', () {
    var produto = {
      "id": 123,
      "name": 'teclado',
      "url": "null",
      "price": 100,
      "quantity": 3,
    };
    var produto2 = {
      "id": 124,
      "name": 'mouse',
      "url": "null",
      "price": 150,
      "quantity": 1,
    };
    var produto3 = {
      "id": 125,
      "name": 'tela',
      "url": "null",
      "price": 400,
      "quantity": 4,
    };

    final rec_test = cat.Record.fromMap(produto);
    final rec_test2 = cat.Record.fromMap(produto2);
    final rec_test3 = cat.Record.fromMap(produto3);
    final catalog_test = cat.CatalogModel();

    final cart_test = cart.CartModel(catalog_test, null );

    cart_test.addItemToCatalogItemsList(rec_test);
    cart_test.addItemToCatalogItemsList(rec_test2);
    cart_test.addItemToCatalogItemsList(rec_test3);

    cart_test.add(rec_test);
    cart_test.add(rec_test2);
    cart_test.add(rec_test3);

    expect(cart_test.items[0].name , "teclado");
    expect(cart_test.items[1].name , "mouse");
    expect(cart_test.items[2].name , "tela");
  });

    test('verifica os produtos no carrinho (com remoção)', () {
    var produto = {
      "id": 123,
      "name": 'teclado',
      "url": "null",
      "price": 100,
      "quantity": 3,
    };
    var produto2 = {
      "id": 124,
      "name": 'mouse',
      "url": "null",
      "price": 150,
      "quantity": 1,
    };
    var produto3 = {
      "id": 125,
      "name": 'tela',
      "url": "null",
      "price": 400,
      "quantity": 4,
    };

    final rec_test = cat.Record.fromMap(produto);
    final rec_test2 = cat.Record.fromMap(produto2);
    final rec_test3 = cat.Record.fromMap(produto3);
    final catalog_test = cat.CatalogModel();

    final cart_test = cart.CartModel(catalog_test, null );

    cart_test.addItemToCatalogItemsList(rec_test);
    cart_test.addItemToCatalogItemsList(rec_test2);
    cart_test.addItemToCatalogItemsList(rec_test3);

    cart_test.add(rec_test);
    cart_test.add(rec_test2);
    cart_test.add(rec_test3);
    cart_test.rmv(rec_test3);

    expect(cart_test.items[0].name , "teclado");
    expect(cart_test.items[1].name , "mouse");
  });

  test('verifica totalPrice do carrinho (sem remoção)', () {
    var produto = {
      "id": 123,
      "name": 'teclado',
      "url": "null",
      "price": 100,
      "quantity": 3,
    };
    var produto2 = {
      "id": 124,
      "name": 'mouse',
      "url": "null",
      "price": 150,
      "quantity": 1,
    };
    var produto3 = {
      "id": 125,
      "name": 'tela',
      "url": "null",
      "price": 400,
      "quantity": 4,
    };

    final rec_test = cat.Record.fromMap(produto);
    final rec_test2 = cat.Record.fromMap(produto2);
    final rec_test3 = cat.Record.fromMap(produto3);
    final catalog_test = cat.CatalogModel();

    final cart_test = cart.CartModel(catalog_test, null );

    cart_test.addItemToCatalogItemsList(rec_test);
    cart_test.addItemToCatalogItemsList(rec_test2);
    cart_test.addItemToCatalogItemsList(rec_test3);

    cart_test.add(rec_test);
    cart_test.add(rec_test2);
    cart_test.add(rec_test3);

    expect(cart_test.totalPrice , 650);
  });

  test('verifica totalPrice do carrinho (com remoção)', () {
    var produto = {
      "id": 123,
      "name": 'teclado',
      "url": "null",
      "price": 100,
      "quantity": 3,
    };
    var produto2 = {
      "id": 124,
      "name": 'mouse',
      "url": "null",
      "price": 150,
      "quantity": 1,
    };
    var produto3 = {
      "id": 125,
      "name": 'tela',
      "url": "null",
      "price": 400,
      "quantity": 4,
    };

    final rec_test = cat.Record.fromMap(produto);
    final rec_test2 = cat.Record.fromMap(produto2);
    final rec_test3 = cat.Record.fromMap(produto3);
    final catalog_test = cat.CatalogModel();

    final cart_test = cart.CartModel(catalog_test, null );

    cart_test.addItemToCatalogItemsList(rec_test);
    cart_test.addItemToCatalogItemsList(rec_test2);
    cart_test.addItemToCatalogItemsList(rec_test3);

    cart_test.add(rec_test);
    cart_test.add(rec_test2);
    cart_test.add(rec_test3);
    cart_test.rmv(rec_test3);

    expect(cart_test.totalPrice , 250);
  });
  //End: Testes de card.dart

}