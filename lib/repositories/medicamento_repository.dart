import '../models/medicamento.dart';
import '../database_helper.dart';
import 'dart:convert';

class MedicamentoRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> inserirMedicamento(Map<String, dynamic> medicamento) async {
    // Serializa campos complexos se necessário
    final data = {
      'nome': medicamento['nome'] ?? '',
      'dosagem': medicamento['dose'] ?? medicamento['dosagem'] ?? '',
      'detalhes': jsonEncode(medicamento),
    };
    return await _dbHelper.insert('remedios', data);
  }

  Future<List<Medicamento>> listarMedicamentos() async {
    final lista = await _dbHelper.list('remedios');
    return lista.map((item) {
      final detalhes = item['detalhes'] as String?;
      Map<String, dynamic> extras = {};
      if (detalhes != null && detalhes.isNotEmpty) {
        try {
          extras = jsonDecode(detalhes);
        } catch (_) {
          extras = {};
        }
      }
      // Merge básico dos dados
      final merged = {...item, ...extras};
      return Medicamento.fromMap(merged);
    }).toList();
  }

  Future<int> atualizarMedicamento(Medicamento medicamento) async {
    final data = {
      'id': medicamento.id,
      'nome': medicamento.nome,
      'dosagem': medicamento.dose,
      'detalhes': jsonEncode(medicamento.toMap()),
    };
    return await _dbHelper.update('remedios', data);
  }

  Future<int> deletarMedicamento(int id) async {
    return await _dbHelper.delete('remedios', id);
  }
}
