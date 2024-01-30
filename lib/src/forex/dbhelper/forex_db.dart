import 'package:sqflite/sqflite.dart' as sql;

import '../model/forex_model.dart';

class Sqlhelper {
  static Future<void> createTables(sql.Database database) async {
    await database.rawQuery('''
  CREATE TABLE country(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    unit TEXT,
    name TEXT,
    buy TEXT,
    sell TEXT,
    iso3 TEXT
  )
''');
  }

  static Future<sql.Database> db() async {
    //database ma connect
    return sql.openDatabase("bdb.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(
      String iso3, String name, String sell, String unit, String buy) async {
    final db = await Sqlhelper.db();
    final data = {
      "name": name,
      "unit": unit,
      "iso3": iso3,
      "sell": sell,
      "buy": buy,
    };
    final id = await db.insert("country", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Country>> getItems() async {
    final db = await Sqlhelper.db();
    List<Map<String, dynamic>> results =
        await db.query("country", orderBy: "id");

    return List.generate(
      // results.length, (index) => Country.fromJson(results[index]));
      results.length,
      (index) => Country(
        iso3: results[index]['iso3'],
        name: results[index]['name'],
        unit: results[index]['unit'],
        buy: results[index]['buy'],
        sell: results[index]['sell'],
      ),
    );
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await Sqlhelper.db();
    return db.query("country", where: "id=?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id, String name, String sell, String unit, String buy) async {
    final db = await Sqlhelper.db();
    final data = {"name": name, "buy": buy, "sell": sell, "unit": unit};
    final result =
        await db.update("country", data, where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteAll() async {
    final db = await Sqlhelper.db();
    try {
      await db.delete("country");
    } catch (e) {
      return;
    }
  }

  static Future<void> deleteItem(int id) async {
    final db = await Sqlhelper.db();
    try {
      await db.delete("country", where: "id=?", whereArgs: [id]);
    } catch (e) {
      return;
    }
  }
}
