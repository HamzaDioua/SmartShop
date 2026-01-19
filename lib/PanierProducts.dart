import 'package:flutter/material.dart';

class PanierProducts extends ChangeNotifier {
  List<Map<String, dynamic>> panier = [];

  void add(Map<String, dynamic> product) {
    panier.add(product);
    notifyListeners();
  }

  void remove(Map<String, dynamic> product) {
    panier.remove(product);
    notifyListeners();
  }

  int get count => panier.length;
}
