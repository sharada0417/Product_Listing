import 'package:app_routing/data/product_data.dart';
import 'package:app_routing/models/product_model.dart';
import 'package:flutter/material.dart';

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
            onPressed: () {},
            backgroundColor: Colors.deepOrange,
            child: Icon(Icons.favorite, color: Colors.white),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.deepOrange,
            child: Icon(Icons.shopping_cart, color: Colors.white),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Product product = products[index];
          return Card(
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    product.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 50),
                  //todo: fill this
                  Text("0"),
                ],
              ),
              subtitle: Text("\$${product.price.toString()}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
