import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/PanierProducts.dart';
import './MainScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_)=>PanierProducts(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static bool isDark = false;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smart Shop",
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: "Poppins",
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: "Poppins",
        brightness: Brightness.dark,
      ),
      themeMode: MyApp.isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Mainscreen(),
    ); 
  }
}

void changeTheme(bool value, BuildContext context) {
  MyApp.isDark = value;
  context.findAncestorStateOfType<_MyAppState>()?.setState(() {});
}