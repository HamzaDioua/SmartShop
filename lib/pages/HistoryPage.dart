import 'package:flutter/material.dart';
class Log {
  static List<String> actions = [];
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  @override
  State<HistoryPage> createState()=>_HistoryPageState();}






class _HistoryPageState extends State<HistoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historique')),
      body: Column(
        children: [
          Expanded(
  child: ListView(
    children: Log.actions.map((action)=>
       ListTile(
        title: Text(action),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              Log.actions.remove(action);
            });
          },
        ),
      )
    ).toList(),
  ),
),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                        Log.actions.clear();
                      });
            },
            child: Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }
}
