import 'package:flutter/material.dart';
import '../Models/product.dart';
import '../Services/json_service.dart';
import 'favorites_page.dart';
import 'SectionTitle.dart';
import 'ProductDetailsPage.dart';
import 'MonProfile.dart';
import './CartPage.dart';
import 'SettingsPage.dart';
import 'HistoryPage.dart';
import 'SearchPage.dart';
import '../widgets/product_tile.dart';
import 'api_products_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final JsonService _jsonService = JsonService(); 
  String selectedCategory = "Phones";
  static List<Product>_products =[];
  Future<void> _loadProductsFromJson() async {
    try {
      
      final products = await _jsonService.loadProducts();

      
      setState(() {
        
        _products = products;
      });
    } catch (e) {
     
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du chargement des produits: $e')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SmartShop"),
        actions: [IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApiProductsPage()),
              );
            },
            icon: const Icon(Icons.cloud_download),
          ),
            IconButton(
            icon: const Icon(Icons.download),
            onPressed: _loadProductsFromJson,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cartpage()),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
            icon: const Icon(Icons.history),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage(products: _products)),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
            },
            icon: const Icon(Icons.favorite),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(Icons.shopping_bag, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'SmartShop',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Accueil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MonProfile()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Paramètres'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SectionTitle(title: "Produits recommandés"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryButton("Phones"),
                      _buildCategoryButton("Laptops"),
                      _buildCategoryButton("Watch"),
                      _buildCategoryButton("Gaming"),
                      _buildCategoryButton("Accessoires"),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Catégorie sélectionnée : $selectedCategory",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
           _products.isEmpty
              ? Center(child: Text("Aucun produit disponible"))
              : Column(
                  children: _products.map((p) {
                    return ListTile(
                      title: ProductTile(
                        name: p.name,
                        price: p.price.toString(),
                        imagePath: p.image,
                        id: p.id,
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(p.image, width: 100, height: 100),
                                  Text(
                                    p.name,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${p.price} DH",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetailsPage(
                                id: p.id,
                                name: p.name,
                                image: p.image,
                                description: p.description,
                                prix: p.price,
                              ),
                                        ),
                                      );
                                    },
                                    child: Text("Voir détails"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: selectedCategory == category ? Colors.teal : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
              color: selectedCategory == category ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
