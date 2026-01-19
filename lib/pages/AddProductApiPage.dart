import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddProductApiPage extends StatefulWidget{

  const AddProductApiPage({super.key});
  @override
  State<AddProductApiPage> createState()=>_AddProductApiPageState();
} 

class _AddProductApiPageState extends State<AddProductApiPage>{
  final TextEditingController name =TextEditingController();
  final TextEditingController description =TextEditingController();
  final TextEditingController priceController =TextEditingController();

  Future<void> sendData()async{
    final response = await http.post( 
      Uri.parse("http://10.0.2.2:3000/api/products"), 
      headers: {"Content-Type": "application/json"}, 
      body: jsonEncode({ 
        "name": name.text,                                 
        "price": double.parse(priceController.text),        
        "desc": description.text,                          
        "category": "Mobile",                               
        "imagePath": "https://via.placeholder.com/150",      
      }), 
    ); 

    if(response.statusCode==201 || response.statusCode==200){ 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Produit envoyé avec succès!"))
      );
    }else {
      throw Exception("Erreur serveur : ${response.statusCode}");
    }
  }
 
  @override
  Widget build(BuildContext conetxt){
    return Scaffold(
      appBar: AppBar(title: Text("Formulaire :"),),
      body:Padding(
        padding: EdgeInsets.all(16.0),
        child:Column(
          children: [
            TextField(controller:name ,decoration:InputDecoration(labelText:"Nom du produit" ),),
            TextField(controller:priceController,decoration: InputDecoration(labelText:"Price du produit"),),
            TextField(controller: description,decoration: InputDecoration(labelText:"description du produit"),),
            Center(child:ElevatedButton(onPressed: sendData, child: Text("Envoyer au serveur")) ,)
          ],
        ),
      )
    );
  }
}