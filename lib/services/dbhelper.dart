import 'package:elgawda_by_shay_b_haleb_new/models/prodact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/prodact.dart';

class DbHehper {
  static final DbHehper _indtance = DbHehper.internal();
  factory DbHehper() => _indtance;
  String consultantDBName = 'consultantproduct.db';
  String tableName = 'courses';
  String tableVisa = 'visa';
  DbHehper.internal();
  static Database? _db;
  Future<Database?> createDataBase() async {
    if (_db != null) {
      return _db;
    }
    String path = join(await getDatabasesPath(), consultantDBName);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int v) {
        db.execute(
          'create table $tableName(id integer primary key autoincrement ,' +
              'title varcher(50) , proImageUrl varcher(255) ,' +
              'CoursesId integer,price double)',
        );
        // db.execute(
        //   'create table $tableVisa(id integer primary key autoincrement ,' +
        //       'cvvNumber varcher(50),exDate varcher(50),visaNumber varcher(50),type varcher(50))',
        // );
      },
    );
    return _db;
  }

  Future<int> createProduct(CoursesProdect product) async {
    Database? db = await createDataBase();
    return db!.insert(
      tableName,
      product.toMap(),
    );
  }

  Future<List> allProduct() async {
    Database? db = await createDataBase();
    return db!.query(
      tableName,
    );
  }

  Future<int> deleteProduct(int id) async {
    Database? db = await createDataBase();
    return db!.delete(tableName, where: 'id=?', whereArgs: [id]);
  }

  deleteAllProduct() async {
    Database? db = await createDataBase();
    return db!.delete(tableName);
  }

  Future<CoursesProdect?> getProductById(int id) async {
    Database? db = await createDataBase();
    var result =
        await db!.query(tableName, where: 'CoursesId=?', whereArgs: [id]);
    return result.isNotEmpty ? CoursesProdect.formMap(result.first) : null;
  }
//////////////VISIA????????????///////////
  // Future<int> createvisa(CustomVisa visa) async {
  //   Database db = await createDataBase();
  //   return db.insert(
  //     tableVisa,
  //     visa.toMap(),
  //   );
  // }

  // Future<List> allvisa() async {
  //   Database db = await createDataBase();
  //   return db.query(
  //     tableVisa,
  //   );
  // }

  // Future<int> deletevisa(int id) async {
  //   Database db = await createDataBase();
  //   return db.delete(tableVisa, where: 'id=?', whereArgs: [id]);
  // }

  // deleteAllvisa() async {
  //   Database db = await createDataBase();
  //   return db.delete(tableVisa);
  // }
}
