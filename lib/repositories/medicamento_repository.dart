import '../models/medicamento.dart';
import '../database_helper.dart';

class MedicamentoRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> inserirMedicamento(Map<String, dynamic> medicamento) async {
    return await _dbHelper.inserirRemedio(medicamento);
  }

  Future<List<Medicamento>> listarMedicamentos() async {
    final lista = await _dbHelper.listarRemedios();
    return lista.map((e) => Medicamento.fromMap(e)).toList();
  }

  Future<int> atualizarMedicamento(Medicamento medicamento) async {
    return await _dbHelper.atualizarRemedio(medicamento.toMap());
  }

  Future<int> deletarMedicamento(int id) async {
    return await _dbHelper.deletarRemedio(id);
  }
}
