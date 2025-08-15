import 'package:app_routing/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  //cart items state
  final Map<String, CartItem> _items = {};

  //getter
  Map<String, CartItem> get items {
    return {..._items};
  }

  //add items
  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
      print("add existing data");
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(id: productId, title: title, price: price, quantity: 1),
      );
    }
  }
}
