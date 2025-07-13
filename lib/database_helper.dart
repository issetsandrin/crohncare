import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'minha_doenca_crohn.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE remedios ADD COLUMN detalhes TEXT');
        }
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    debugPrint('Banco de dados sendo CRIADO do zero!');
    await db.execute('''
      CREATE TABLE alarmes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        dosagem TEXT,
        horario TEXT,
        dias TEXT,
        ativo INTEGER,
        remedio TEXT,
        som TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE remedios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        dosagem TEXT,
        detalhes TEXT
      )
    ''');
  }

  // Funções CRUD genéricas
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final dbClient = await db;
    return await dbClient.insert(table, data);
  }

  Future<Map<String, dynamic>?> find(String table, int id) async {
    final dbClient = await db;
    final result = await dbClient.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> list(String table) async {
    final dbClient = await db;
    return await dbClient.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> data) async {
    final dbClient = await db;
    return await dbClient.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  Future<int> delete(String table, int id) async {
    final dbClient = await db;
    return await dbClient.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
