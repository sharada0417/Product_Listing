import 'package:app_routing/data/product_data.dart';
import 'package:app_routing/models/product_model.dart';
import 'package:app_routing/provider/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite page",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Consumer<FavouriteProvider>(
        builder:
            (
              BuildContext context,
              FavouriteProvider favProvider,
              Widget? child,
            ) {
              final favItems = favProvider.favourites.entries
                  .where((entry) => entry.value)
                  .map((entry) => entry.key)
                  .toList();

              if (favItems.isEmpty) {
                return Center(child: Text("No favourite added yet"));
              }
              return ListView.builder(
                itemCount: favItems.length,
                itemBuilder: (context, index) {
                  final productId = favItems[index];
                  final Product product = ProductData().products.firstWhere(
                    (product) => product.id == productId,
                  );

                  return Card(
                    child: ListTile(
                      title: Text(product.title),
                      subtitle: Text("\$${product.price}"),
                      trailing: IconButton(
                        onPressed: () {
                          favProvider.toggleFavourites(product.id);
                          //show snackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Removed from favorites!"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
      ),
    );
  }
}
