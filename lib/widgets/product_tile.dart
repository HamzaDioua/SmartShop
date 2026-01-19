import 'package:flutter/material.dart';
import '../Services/db_service.dart';

class ProductTile extends StatefulWidget {
  final String name;
  final String price;
  final String imagePath;
  final int id;
  const ProductTile({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.id
  });

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool isFavorate = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          child: Image.asset(
            widget.imagePath,
            width: 100,
            height: 100,
          ),
        ),
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              widget.price,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        
        IconButton(
          onPressed: () {
            if(isFavorate==false){DbService().insertFavorite({"id":widget.id,"name":widget.name,"price":widget.price,"imagePath":widget.imagePath});}
            else{DbService().deleteFavorite(widget.id);}
            setState(() {
              isFavorate = !isFavorate;
            });
          },
          icon: Icon(
            isFavorate ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
