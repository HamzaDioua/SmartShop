import 'package:flutter/material.dart';
import '../main.dart';
import 'PrefsPage.dart';
import 'AddProductApiPage.dart';
import 'EditProductApiPage.dart';
import 'api_products_page.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  double FontSize = 14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paramètres',style: TextStyle(fontSize:FontSize)), actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductApiPage()),
              );
            },
            icon: const Icon(Icons.account_box),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApiProductsPage()),
              );
            },
            icon: const Icon(Icons.cloud_download),
          ),IconButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>EditProductApiPage())), icon: Icon(Icons.edit))]
  ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Mode sombre',style: TextStyle(fontSize:FontSize)),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
                changeTheme(value, context);
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Taille du texte',style: TextStyle(fontSize:FontSize),),
            subtitle: Text('Taille actuelle: ${FontSize.toInt()}',style: TextStyle(fontSize:FontSize)),
            trailing: SizedBox(
              width: 100, 
              child: Slider(
                value: FontSize,
                min: 10,
                max: 30,
                divisions: 10,
                onChanged: (value) {
                  setState(() {
                    FontSize = value;
                  });

                },
              ),
            ),
          ),
          Divider(),
          ElevatedButton(onPressed: ()=>{Navigator.push(context,
          MaterialPageRoute(builder: (context) =>PrefsPage() ,)
          )}, child:Text("Aller aux Préférences"))
        ],
      ),
    );
  }
}
