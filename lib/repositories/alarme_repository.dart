import 'package:sqflite/sqflite.dart';
import '../database_helper.dart';
import '../models/alarme.dart';

class AlarmeRepository {
  Future<void> removerAlarme(int id) async {
    final db = await _db;
    await db.delete('alarmes', where: 'id = ?', whereArgs: [id]);
  }

  Future<Database> get _db async => await DatabaseHelper().db;

  Future<void> insertAlarme(Alarme alarme) async {
    final db = await _db;
    await db.insert(
      'alarmes',
      alarme.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Alarme>> getAlarmes() async {
    final db = await _db;
    final maps = await db.query('alarmes');
    return maps.map((e) => Alarme.fromMap(e)).toList();
  }
}
