import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

class ApiProductsPage extends StatefulWidget {
  const ApiProductsPage({super.key});
  @override
  State<ApiProductsPage> createState() => _ApiProductsPageState();
}

class _ApiProductsPageState extends State<ApiProductsPage> {
  List data = []; 

  @override
  void initState() {
    super.initState();
    fetchData(); 
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse("http://10.0.2.2:3000/api/products")).timeout(Duration(seconds: 5)); 
      
      if (response.statusCode == 200) {
        setState(() {
          final jsonData = jsonDecode(response.body);
          data = jsonData['data'] ?? []; 
        });
      } else if (response.statusCode == 500) {
        throw Exception("Erreur serveur – Réessayez plus tard");
      }
    } on SocketException {
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erreur réseau – Vérifiez votre connexion")));
    } on TimeoutException {
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Délai de requête expiré – Réessayez")));
    } catch (e) {
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


  
  Future<void> deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse("http://10.0.2.2:3000/api/products/$id"),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Produit supprimé sur le serveur")));

      setState(() {
        data.removeWhere((product) => product['id'] == id);
      });
    } else {
      throw Exception("Erreur lors de la suppression du produit");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des produits')),
      body: data.isEmpty
          ? Center(child: CircularProgressIndicator()) 
          : ListView(
              children: data.map((product) {
                return ListTile(
                  title: Row(children:[
                    Text("Produit : "),
                    Text(product['name']),
                    Text(" avec Id : "),
                    Text("${product['id']}")
                  ]), 
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteProduct(product['id']);
                    },
                  ),
                );
              }).toList(),
            ),
    );
  }
}