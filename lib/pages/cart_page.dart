import 'package:app_routing/models/cart_model.dart';
import 'package:app_routing/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Card page",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder:
            (BuildContext context, CartProvider cartProvider, Widget? child) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.items.length,
                      itemBuilder: (context, index) {
                        final CartItem cartItem = cartProvider.items.values
                            .toList()[index];
                        return Container(
                          color: Color.fromARGB(107, 255, 153, 0),
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(cartItem.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cartItem.id),
                                Text(
                                  "\$${cartItem.price} x ${cartItem.quantity}",
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cartProvider.removeSingleItem(cartItem.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("One Item Removed"),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {
                                    cartProvider.removeItem(cartItem.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Remove from cart"),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.remove_shopping_cart),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Total : \$${cartProvider.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        cartProvider.clearAll();
                        //show snackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Cart cleared!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Text("Text cart!"),
                    ),
                  ),
                ],
              );
            },
      ),
    );
  }
}
