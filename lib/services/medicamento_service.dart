import '../models/medicamento.dart';
import '../repositories/medicamento_repository.dart';

class MedicamentoService {
  final MedicamentoRepository _repository = MedicamentoRepository();

  Future<void> adicionarMedicamento(Map<String, dynamic> medicamento) async {
    await _repository.inserirMedicamento(medicamento);
  }

  Future<List<Medicamento>> obterMedicamentos() async {
    return await _repository.listarMedicamentos();
  }

  Future<void> atualizarMedicamento(Medicamento medicamento) async {
    await _repository.atualizarMedicamento(medicamento);
  }

  Future<void> removerMedicamento(int id) async {
    await _repository.deletarMedicamento(id);
  }
}
