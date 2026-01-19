import 'package:flutter/material.dart';
import '../pages/ProductDetailsPage.dart';

class ProductCard extends StatefulWidget {
  final int id;
  final String name;
  final String image;
  final String description;
  final double prix;

  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.prix,
  });
  @override
  State<ProductCard> createState() => _ProductCard();
}

class _ProductCard extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset(widget.image, fit: BoxFit.contain)),
            const SizedBox(height: 8),
            Text(
              widget.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "${widget.prix.toStringAsFixed(2)} DH",
              style: const TextStyle(color: Colors.green, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsPage(
                      id:widget.id ,
                      name: widget.name,
                      image: widget.image,
                      description: widget.description,
                      prix: widget.prix,
                      onPanierChanged: () {
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
              child: const Text("Details"),
            ),
          ],
        ),
      ),
    );
  }
}