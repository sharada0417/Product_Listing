import 'package:app_routing/data/product_data.dart';
import 'package:app_routing/models/product_model.dart';
import 'package:app_routing/pages/cart_page.dart';
import 'package:app_routing/pages/favourite_page.dart';
import 'package:app_routing/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Online Shop",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavouritePage()),
              );
            },
            backgroundColor: Colors.deepOrange,
            heroTag: "favourite_btn",
            child: Icon(Icons.favorite, color: Colors.white),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            backgroundColor: Colors.deepOrange,
            heroTag: "shopping_btn",
            child: Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Product product = products[index];
          return Card(
            child: Consumer<CartProvider>(
              builder:
                  (
                    BuildContext context,
                    CartProvider cartProvider,
                    Widget? child,
                  ) {
                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 50),
                          Text(
                            cartProvider.items.containsKey(product.id)
                                ? cartProvider.items[product.id]!.quantity
                                      .toString()
                                : "0",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      subtitle: Text("\$${product.price.toString()}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite),
                          ),
                          IconButton(
                            onPressed: () {
                              cartProvider.addItem(
                                product.id,
                                product.price,
                                product.title,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Added to cart"),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.shopping_cart,
                              color: cartProvider.items.containsKey(product.id)
                                  ? Colors.deepOrange
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
            ),
          );
        },
      ),
    );
  }
}
