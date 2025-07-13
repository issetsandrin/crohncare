import '../database_helper.dart';
import '../models/alarme.dart';

class AlarmeRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> inserirAlarme(Alarme alarme) async {
    return await _dbHelper.insert('alarmes', alarme.toMap());
  }

  Future<List<Alarme>> listarAlarmes() async {
    final lista = await _dbHelper.list('alarmes');
    return lista.map((e) => Alarme.fromMap(e)).toList();
  }

  Future<int> atualizarAlarme(Alarme alarme) async {
    return await _dbHelper.update('alarmes', alarme.toMap());
  }

  Future<int> deletarAlarme(int id) async {
    return await _dbHelper.delete('alarmes', id);
  }
}
