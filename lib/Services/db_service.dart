import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  static Database? _database;


  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }
  
  Future<Database>initDatabase() async{
  String path = join(await getDatabasesPath(),"Favories.db");
  return await openDatabase(path,version:1,onCreate:(db,version){
    db.execute("CREATE TABLE Favories(id INTEGER PRIMARY KEY,name TEXT,price TEXT,imagePath TEXT)");
  });
  }
  
  Future<void>insertFavorite(Map<String,dynamic>Favorie) async{
    final db = await database;
    await db.insert(
      "Favories",
      Favorie,
      conflictAlgorithm: ConflictAlgorithm.replace
    ); }

    Future<List<Map<String,dynamic>>> getFavorites()async{
      final db = await database;
      return await db.query("Favories");
    }
    Future<void>deleteFavorite(int id)async{
      final db = await database;
      await db.delete(
        "Favories",
        where:"id = ?",
        whereArgs:[id],

      );
    }
  }