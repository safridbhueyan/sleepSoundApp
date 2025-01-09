import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('mixes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE mixes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        sounds TEXT,  -- Store sounds as a JSON string
        volumes TEXT  -- Store volumes as a JSON string
      )
    ''');
  }

  // Insert a new mix
  Future<int> insertMix(Map<String, dynamic> mix) async {
    final db = await instance.database;
    return await db.insert('mixes', mix);
  }

  // Get all mixes
  Future<List<Map<String, dynamic>>> getAllMixes() async {
    final db = await instance.database;
    return await db.query('mixes');
  }

  // Get a mix by id
  Future<Map<String, dynamic>?> getMixById(int id) async {
    final db = await instance.database;
    final result = await db.query('mixes', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // Delete a mix by id
  Future<int> deleteMix(int id) async {
    final db = await instance.database;
    return await db.delete('mixes', where: 'id = ?', whereArgs: [id]);
  }

  // Update a mix
  Future<int> updateMix(Map<String, dynamic> mix, int id) async {
    final db = await instance.database;
    return await db.update('mixes', mix, where: 'id = ?', whereArgs: [id]);
  }
}
