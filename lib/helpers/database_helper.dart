import 'package:formation_flutter/dog_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final _databaseName = "dog.db";
  final _databaseVersion = 1;
  final tableDog = 'dog_table';

  //table dog
   final columnIdDog = 'id';
   final columnName = 'name';
   final columnAge = 'age';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE  IF NOT EXISTS $tableDog(
            $columnIdDog INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL, 
            $columnAge TEXT NOT NULL       
    )
    
    ''');
  }

  Future<Dog> createNewDog(Dog dog) async {
    final db = await instance.database;
    dog.id = await db.insert(tableDog, dog.toJson());
    return dog;
  }

  //fonction pour modifier un dog
  Future<int> updateDog(Dog dog) async {
    final db = await instance.database;
    return db.update(
      tableDog,
      dog.toJson(),
    );
  }

  //Fonction pour supprimer un dog en fonction de son Id dans la table Dog
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(tableDog);
  }
//Fonction pour recupérer la liste des dogs après la creatiion
  Future<List<Dog>?> readAllDog() async {
    final db = await database;
    List<Map<String, dynamic>> res;
    res = await db.rawQuery("SELECT * FROM $tableDog");
    List<Dog> list = res.isNotEmpty ? res.map((c) => Dog.fromJson(c)).toList() : [];
    print("resultat de res est $res");
    return list;
  }
}