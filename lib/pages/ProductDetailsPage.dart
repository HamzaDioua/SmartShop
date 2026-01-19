import 'package:flutter/material.dart';
import '../MainScreen.dart';
import 'HistoryPage.dart';
import '../Services/db_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../PanierProducts.dart';
import 'package:provider/provider.dart';
class ProductDetailsPage extends StatefulWidget {
  final int id;
  final String name;
  final String image;
  final String description;
  final double prix;
  final VoidCallback? onPanierChanged;

  const ProductDetailsPage({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.prix,
    this.onPanierChanged,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool added = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    added = false;
  }

  Future<void> sendProductToServer() async {
    setState(() {
      isLoading = true;
    });

    try {
      final url = Uri.parse('http://10.0.2.2:3000/api/products');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': widget.name,
          'price': widget.prix,
          'imagePath': widget.image,
          'desc': widget.description,
          'category': 'Mobile',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("✅ Produit envoyé au serveur avec succès !"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Erreur: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(widget.image, width: 250, height: 250)),
            const SizedBox(height: 10),

            Text(
              widget.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),
            Text(widget.description),

            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star_border),
                Icon(Icons.star_border),
              ],
            ),

            const SizedBox(height: 8),
            Text(
              "${widget.prix} DH",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const Spacer(),

            Center(
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Log.actions.add(
                        "Produit ${widget.name} ajouté au panier",
                      );
                      setState(() {
                        added = !added;
                      });

                      final panierProvider = context.read<PanierProducts>();

                      if (added) {
                        panierProvider.add({
                          'id': widget.id,
                          'name': widget.name,
                          'image': widget.image,
                          'description': widget.description,
                          'prix': widget.prix,
                        });
                      } else {
                        panierProvider.remove({
                          'id': widget.id,
                          'name': widget.name,
                          'image': widget.image,
                          'description': widget.description,
                          'prix': widget.prix,
                        });
                      }

                      Mainscreen.panierNotifier.value =
                          Mainscreen.panier.length;
                      widget.onPanierChanged?.call();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            added
                                ? "Produit ajouté au panier !"
                                : "Produit retiré du panier !",
                          ),
                        ),
                      );
                    },
                    icon: Icon(added ? Icons.check : Icons.add_shopping_cart),
                    label: Text(
                      added ? "Retirer du panier" : "Ajouter au panier",
                    ),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () => DbService().insertFavorite({
                      "id": widget.id,
                      "name": widget.name,
                      "price": widget.prix,
                      "imagePath": widget.image,
                    }),
                    child: const Text("Ajouter aux Favoris"),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton.icon(
                    onPressed: isLoading ? null : sendProductToServer,
                    icon: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.cloud_upload),
                    label: Text(
                      isLoading ? "Envoi en cours..." : "Envoyer au serveur",
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
