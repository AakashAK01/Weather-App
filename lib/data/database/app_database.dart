import 'package:sqflite/sqflite.dart' as sql;
import 'package:weather_app_latest/data/database/city.dart';
import 'package:weather_app_latest/logger.dart';

class CityDatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE cities (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    city TEXT     
                    )''');
  }

  static Future<sql.Database> db() {
    return sql.openDatabase('cityList.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      logger.i("Rukko Jara saba karo Db Creating ho rahe hai");
      await createTables(database);
    });
  }

  static Future<int> createCity(String city) async {
    final db = await CityDatabaseHelper.db();
    final data = {'city': city};
    final id = await db.insert('cities', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getCities() async {
    final db = await CityDatabaseHelper.db();
    logger.i(db.query('cities', orderBy: "id"));
    return db.query('cities', orderBy: "id");
  }

  static Future<void> deleteCity(int id) async {
    final db = await CityDatabaseHelper.db();
    try {
      await db.delete("cities", where: "id=?", whereArgs: [id]);
    } catch (err) {
      logger.e("Something corrupte", StackTrace.current);
    }
  }
}
