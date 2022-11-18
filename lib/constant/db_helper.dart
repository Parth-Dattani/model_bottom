import 'package:model_bottom/model/data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? db;
  final String tableName = 'myTab';

  Future<Database> get database async {
    if (database != null) {
      return database;
    }
    db = await initDB();
    return database;
  }

  initDB() async {
    String dbpath = await getDatabasesPath();
    String path = await join(dbpath, 'myNote.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Future<Database> initDB() async {
  //   String path = await getDatabasesPath();
  //   return openDatabase(join(path, 'todo.db'),
  //       onCreate:
  //
  //           (database, version) async {
  //         await database.execute(
  //           "CREATE TABLE data(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT NOT NULL,description TEXT NOT NULL, date DATETIME, status TEXT  )",
  //         );}, version: 1);
  // }

  Future _onCreate(Database db, int version) async {
    final id = 'INTEGER PRIMARY KEY AUTOINCEMENT';
    final title = 'TEXT';

    db.execute(
        "CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT)");
    print("db Created Successfull");
  }

  //insert data
  Future<void> addDataBase(DataModel dataModel) async {
    final db = await initDB();

    await db.insert(tableName, dataModel.toMap());
    print("db create and insert ok");
  }

  //update data
  Future<void> updates(DataModel dataModel) async {
    final db = await initDB();
    await db.update(tableName, dataModel.toMap(),
        where: 'id = ?', whereArgs: [dataModel.id]);
  }

  //delete data
  Future<void> deleteDB(int id) async {
    final db = await initDB();
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  //retrive data
  Future<List<DataModel>> getData() async {
    final db = await initDB();
    List<Map<String, dynamic>> query =
        await db.query(tableName, columns: ['id', 'title']);
    //List<Map>  Qquery = await db.query(tableName, columns:['id', 'title']);
    List<DataModel> s = <DataModel>[];

    for (int i = 0; i < query.length; i++) {
      s.add(DataModel.fromMap(query[i]));
    }
    return s;
  }
}

// class DatabaseHandler {

//   Future<List<Task>> retriveAllTask() async{
//     final db = await initDB();
//     final List<Map<String,dynamic>> query = await db.query('data');
//     return query.map((e) => Task.fromMap(e)).toList();
//   }
