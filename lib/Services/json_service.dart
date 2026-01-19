import 'dart:convert';
import '../Models/product.dart';
import 'package:flutter/services.dart';
class JsonService {
  Future<List<Product>> loadProducts() async {
    final String response = await rootBundle.loadString('assets/products.json');
    final List<dynamic> data = json.decode(response);
    return data.map((item) => Product.fromJson(item)).toList();
  }
}
