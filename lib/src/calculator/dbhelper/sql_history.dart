import 'package:hh/src/calculator/model/conversion.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SqlHistory {
  static Future<void> deleteAll() async {
    final db = await SqlHistory.db();
    try {
      await db.delete("history");
    } catch (e) {
      return;
    }
  }

  static Future<void> createTables(sql.Database database) async {
    await database.rawQuery('''
      CREATE TABLE history(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        inputOfUser DOUBLE,
        output DOUBLE,
        fromCountry TEXT,
        toCountry TEXT
      )
    ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("history.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(double inputOfUser, double to,
      String fromCountry, String toCountry) async {
    final db = await SqlHistory.db();
    final data = {
      "inputOfUser": inputOfUser,
      "output": to,
      "fromCountry": fromCountry,
      "toCountry": toCountry,
    };
    final id = await db.insert("history", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Conversion>> getItems() async {
    final db = await SqlHistory.db();
    List<Map<String, dynamic>> results =
        await db.query("history", orderBy: "id");

    return List.generate(
      results.length,
      (index) => Conversion(
        from: results[index]['inputOfUser'],
        fromCountry: results[index]['fromCountry'],
        to: results[index]['output'],
        toCountry: results[index]['toCountry'],
      ),
    );
  }
}

// import 'package:hh/src/calculator/model/conversion.dart';
// import 'package:sqflite/sqflite.dart' as sql;
//
// class SqlHistory {
//   static Future<void> createTables(sql.Database database) async {
//     await database.rawQuery('''
//       CREATE TABLE history(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         from DOUBLE,
//         to DOUBLE,
//         fromCountry TEXT,
//         toCountry TEXT
//       )
//     ''');
//   }
// }
//
//   static Future<sql.Database> db() async {
//     //database ma connect
//     return sql.openDatabase("history.db", version: 1,
//         onCreate: (sql.Database database, int version) async {
//       await createTables(database);
//     });
//   }
//
//   static Future<int> createItem(double from, double to) async {
//     final db = await SqlHistory.db();
//     final data = {
//       "from": from,
//       "to": to,
//     };
//     final id = await db.insert("country", data,
//         conflictAlgorithm: sql.ConflictAlgorithm.replace);
//     return id;
//   }
//
//   static Future<List<Conversion>> getItems() async {
//     final db = await SqlHistory.db();
//     List<Map<String, dynamic>> results =
//         await db.query("history", orderBy: "id");
//
//     return List.generate(
//       // results.length, (index) => Country.fromJson(results[index]));
//       results.length,
//       (index) => Conversion(
//         from: results[index]['from'],
//         fromCountry: results[index]['fromCountry'],
//        to: results[index]['to'],
//         toCountry: results[index]['toCountry'],
//
//       ),
//     );
//   }
//
//   static Future<List<Map<String, dynamic>>> getItem(int id) async {
//     final db = await SqlHistory.db();
//     return db.query("country", where: "id=?", whereArgs: [id], limit: 1);
//   }
//
//   // static Future<int> updateItem(
//   //     int id, String name, String sell, String unit, String buy) async {
//   //   final db = await SqlHistory.db();
//   //   final data = {"name": name, "buy": buy, "sell": sell, "unit": unit};
//   //   final result =
//   //       await db.update("country", data, where: "id=?", whereArgs: [id]);
//   //   return result;
//   // }
//
//   static Future<void> deleteAll() async {
//     final db = await SqlHistory.db();
//     try {
//       await db.delete("history");
//     } catch (e) {
//       return;
//     }
//   }
//
// //   // static Future<void> deleteItem(int id) async {
// //   //   final db = await Sqlhelper.db();
// //   //   try {
// //   //     await db.delete("country", where: "id=?", whereArgs: [id]);
// //   //   } catch (e) {
// //   //     return;
// //   //   }
// //   // }
// // }
