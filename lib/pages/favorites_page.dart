import 'package:flutter/material.dart';
import '../Services/db_service.dart';
class FavoritesPage extends StatefulWidget{
  const FavoritesPage({super.key});
  @override
  State<FavoritesPage> createState()=>_FavoritesPageState();
}
class _FavoritesPageState extends State<FavoritesPage>{
  late Future<List<Map<String,dynamic>>>Favories;

  @override
  initState(){
    super.initState();
    Favories=DbService().getFavorites();
  }

  Future<void> DeletebyId(int id)async{
    DbService().deleteFavorite(id);
    setState(() {
      Favories=DbService().getFavorites();
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:Text("Favories ") ),
      body:FutureBuilder(future: Favories, builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
         return Center(
          child: CircularProgressIndicator(),
         );
        }
        if(snapshot.hasError){
          return Center(
            child: Text("Error : ${snapshot.error}"),
          );
        }
      
      final List<Map<String,dynamic>> mesFavorie=snapshot.data??[];
      return ListView(
        children: [
        for (Map<String,dynamic> Favorie in mesFavorie)
           ListTile(
            leading: Image.asset(Favorie["imagePath"]),
            title: Text(Favorie["name"]),
            subtitle: Text(Favorie["price"]),
            trailing:IconButton(onPressed:()=>DeletebyId(Favorie['id']), icon: Icon(Icons.delete)),
           )
        ],
      );
      } 
      )
    );
  }
}