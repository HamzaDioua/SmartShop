import 'package:flutter/material.dart';
import './pages/HomePage.dart';
import './pages/MonProfile.dart';
import './pages/ProductDetailsPage.dart';
import './pages/CartPage.dart';
import 'PanierProducts.dart';
import 'package:provider/provider.dart';

class Mainscreen extends StatefulWidget {
  static final List<Map<String, dynamic>> panier = [];
  static final ValueNotifier<int> panierNotifier = ValueNotifier(0);

  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(),
      ProductDetailsPage(
        id: 0,
        name: "Smartphone Android Pro",
        prix: 2999,
        description: "128 Go, 8 Go RAM, Caméra 108MP",
        image: "assets/products/phone.png",
        onPanierChanged: () {
          setState(() {}); 
        },
      ),
      MonProfile(),
    ];

    return Scaffold(
      body: pages[index],
      floatingActionButton: Consumer<PanierProducts>(
        builder: (context, panierProvider, child) {
          return FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Cartpage()),
              );
            },
            child: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (panierProvider.count > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        panierProvider.count.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.teal,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Produits",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
