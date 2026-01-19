import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../MainScreen.dart';


class PrefsPage extends StatefulWidget {
  const PrefsPage({super.key});
  
  @override
  State<PrefsPage> createState() => _PrefsPageState();
}

class _PrefsPageState extends State<PrefsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cartController = TextEditingController();
  
  String name = "invite";
  bool isdark = false;
  int cartCount = 0;
  
  @override
  void initState() {
    super.initState();
    Charger();
  }
  
  Future<void> Charger() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? "";
      isdark = prefs.getBool("darkmode") ?? false;
      
      cartCount = Mainscreen.panier.length;
      
      _cartController.text = cartCount.toString();
      _nameController.text = name;
    });
  }
  
  Future<void> Sauvegarder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name);
    await prefs.setBool("darkmode", isdark);
    
    await prefs.setInt("cart", Mainscreen.panier.length);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Sauvegardé !")),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    
    cartCount = Mainscreen.panier.length;
    _cartController.text = cartCount.toString();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes préférences !"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Votre Nom : ",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                name = value;
              },
              controller: _nameController,
            ),
            
            SizedBox(height: 20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mode Sombre"),
                Switch(
                  value: isdark,
                  onChanged: (valeur) {
                    setState(() {
                      isdark = valeur;
                      changeTheme(isdark, context);
                    });
                  },
                ),
              ],
            ),
            
            SizedBox(height: 20),
            
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Nombre d'articles dans le panier :"),
              ),
              controller: _cartController,
              readOnly: true, 
              enabled: false,
            ),
            
            SizedBox(height: 40),
            
            ElevatedButton(
              onPressed: () => Sauvegarder(),
              child: Text("Sauvegarder"),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _cartController.dispose();
    super.dispose();
  }
}