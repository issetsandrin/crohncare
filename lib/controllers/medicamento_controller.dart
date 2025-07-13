import 'package:mobx/mobx.dart';
import '../models/medicamento.dart';
import '../services/medicamento_service.dart';

part 'medicamento_controller.g.dart';

class MedicamentoController = _MedicamentoControllerBase
    with _$MedicamentoController;

abstract class _MedicamentoControllerBase with Store {
  final MedicamentoService _service = MedicamentoService();

  @action
  Future<void> init() async {
    await carregarMedicamentos();
  }

  @observable
  List<Medicamento> medicamentos = [];

  @observable
  bool isLoading = false;

  @observable
  String? medicamento;

  @observable
  String tipo = 'Outro';

  @observable
  String? dosagem;

  @observable
  String? frequencia;

  @observable
  ObservableList<String> horarios = ObservableList<String>();

  @observable
  bool comAlimento = false;

  @observable
  int estoqueAtual = 0;

  @observable
  String? prescritoPor;

  @observable
  DateTime? dataInicio;

  @observable
  String? observacoes;

  @action
  void resetForm() {
    medicamento = null;
    tipo = 'Outro';
    dosagem = null;
    frequencia = null;
    horarios.clear();
    comAlimento = false;
    estoqueAtual = 0;
    prescritoPor = null;
    dataInicio = null;
    observacoes = null;
  }

  @action
  Future<void> carregarMedicamentos() async {
    isLoading = true;
    medicamentos.clear();
    medicamentos = await _service.obterMedicamentos();
    isLoading = false;
  }

  @action
  Future<void> adicionarMedicamento(Map<String, dynamic> medicamento) async {
    await _service.adicionarMedicamento(medicamento);
    await carregarMedicamentos();
  }

  @action
  Future<void> atualizarMedicamento(Medicamento medicamento) async {
    await _service.atualizarMedicamento(medicamento);
    await carregarMedicamentos();
  }

  @action
  Future<void> removerMedicamento(int id) async {
    await _service.removerMedicamento(id);
    await carregarMedicamentos();
  }
}
