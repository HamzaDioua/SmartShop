import 'package:flutter/material.dart';
import '../main.dart';

class MonProfile extends StatefulWidget {
  const MonProfile({super.key});

  @override
  State<MonProfile> createState() => _MonProfileState();
}

class _MonProfileState extends State<MonProfile> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon Profil"),
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/logo.png",
              width: 150,
              height: 150,
            ),
          ),
          const SizedBox(height: 8),
          Text("Dioua Hamza", textAlign: TextAlign.center),
          const SizedBox(height: 5),
          Text("Etudiant en genie informatique", textAlign: TextAlign.center),
          Divider(),
          SizedBox(height: 11),
          
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text("hamzadioua@gmail.com"),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text("+212 696 737 236"),
                ),
                ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text("Kenitra, Maroc"),
                ),
                
                SwitchListTile(
                  title: Text("Mode sombre"),
                  subtitle: Text("Activer le thème sombre"),
                  value: isDark,
                  secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                  onChanged: (value) {
                    setState(() {
                      isDark = value;
                    });
                    changeTheme(value, context);
                  },
                ),
              ],
            ),
          ),
          
          Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Modifier mes informations"),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}