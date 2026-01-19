import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProductApiPage extends StatefulWidget {
  const EditProductApiPage({super.key});

  @override
  _EditProductApiPageState createState() => _EditProductApiPageState();
}

class _EditProductApiPageState extends State<EditProductApiPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  Future<void> updateProduct() async {
    final productId = idController.text;  
    final productTitle = titleController.text;  
   

    if (productId.isEmpty || productTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ID et titre sont obligatoires")));
      return;
    }

    final response = await http.put(
      Uri.parse("http://10.0.2.2:3000/api/products/$productId"), 
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": productTitle,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Produit modifié avec succès!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur serveur : ${response.statusCode}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le produit'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,  
              decoration: InputDecoration(
                labelText: 'ID du produit', 
              ),
              keyboardType: TextInputType.number,  
            ),
            TextField(
              controller: titleController, 
              decoration: InputDecoration(
                labelText: 'Titre du produit', 
              ),
            ),
            ElevatedButton(
              onPressed: updateProduct,
              child: Text('Envoyer la modification'),
            ),
          ],
        ),
      ),
    );
  }
}