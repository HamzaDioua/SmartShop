import 'package:flutter/material.dart';
import 'ProductDetailsPage.dart';
import '../Models/product.dart';

class SearchPage extends StatefulWidget {
  final List<Product> products;
  
  const SearchPage({super.key, required this.products});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche de produits'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Rechercher un produit',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  filteredProducts = widget.products
                      .where((product) => product.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(child: Text("Aucun produit trouvé"))
                : ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ListTile(
                        leading: Image.asset(product.image, width: 50, height: 50),
                        title: Text(product.name),
                        subtitle: Text("${product.price} DH"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(
                                id: product.id,
                                name: product.name,
                                image: product.image,
                                description: product.description,
                                prix: product.price,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}