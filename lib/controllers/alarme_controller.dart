import 'package:minha_doenca_crohn/services/set_alarme_service.dart';
import 'package:mobx/mobx.dart';
import '../models/alarme.dart';
import '../repositories/alarme_repository.dart';

part 'alarme_controller.g.dart';

class AlarmeController = _AlarmeControllerBase with _$AlarmeController;

abstract class _AlarmeControllerBase with Store {
  @action
  Future<void> init() async {
    await carregarAlarmes();
  }

  @action
  Future<void> removerAlarme(int id) async {
    await _repo.deletarAlarme(id);
    await carregarAlarmes();
  }

  final AlarmeRepository _repo = AlarmeRepository();
  final SetAlarmeService _alarm = SetAlarmeService();

  @observable
  ObservableList<Alarme> alarmes = ObservableList<Alarme>();

  @observable
  bool isLoading = false;

  @action
  Future<void> carregarAlarmes() async {
    isLoading = true;
    final lista = await _repo.listarAlarmes();
    alarmes = ObservableList.of(lista);
    isLoading = false;
  }

  @action
  Future<void> cadastrarAlarme(Alarme alarme) async {
    await _repo.inserirAlarme(alarme);
    _alarm.setAlarme(alarme);
    await carregarAlarmes();
  }
}
