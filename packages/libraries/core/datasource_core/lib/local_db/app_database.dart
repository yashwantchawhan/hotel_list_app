import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'venues.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE venues (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            section TEXT,
            name TEXT,
            city TEXT,
            type TEXT,
            location TEXT,
            lat REAL,
            lng REAL,
            accessibleForGuestPass INTEGER,
            imageUrls TEXT,
            categories_json TEXT,
            openingHours_json TEXT,
            overviewText_json TEXT,
            thingsToDo_json TEXT
          )
        ''');
      },
    );
  }

  @visibleForTesting
  static void reset() {
    _db = null;
  }
}
