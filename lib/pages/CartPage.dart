import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../PanierProducts.dart';

class Cartpage extends StatelessWidget {
  const Cartpage({super.key});

  @override
  Widget build(BuildContext context) {
    final panierProvider = context.watch<PanierProducts>();

    return Scaffold(
      appBar: AppBar(title: const Text("Mon Panier")),
      body: panierProvider.panier.isEmpty
          ? const Center(
              child: Text(
                "Le panier est vide !!",
                style: TextStyle(fontSize: 20, color: Colors.deepOrangeAccent),
              ),
            )
          : ListView.builder(
              itemCount: panierProvider.panier.length,
              itemBuilder: (context, index) {
                final item = panierProvider.panier[index];
                return ListTile(
                  leading: Image.asset(item['image'], width: 50),
                  title: Text(item['name']),
                  subtitle: Text("${item['prix']} DH"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      panierProvider.remove(item);
                    },
                  ),
                );
              },
            ),
    );
  }
}
