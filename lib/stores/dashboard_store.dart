import 'package:mobx/mobx.dart';

part 'dashboard_store.g.dart';

class DashboardStore = _DashboardStore with _$DashboardStore;

abstract class _DashboardStore with Store {
  @observable
  double progresso = 0;

  @observable
  ObservableList<Alarme> alarmes = ObservableList<Alarme>();

  @action
  void marcarComoTomado(int index) {
    if (!alarmes[index].tomado) {
      alarmes[index] = alarmes[index].copyWith(tomado: true);
      _calcularProgresso();
    }
  }

  @action
  void marcarComoAtivo(int index, value) {
    alarmes[index] = alarmes[index].copyWith(ativo: value);
    // _calcularProgresso(); // Não precisa recalcular progresso ao ativar/desativar
  }

  void _calcularProgresso() {
    final total = alarmes.length;
    final tomados = alarmes.where((a) => a.tomado).length;
    progresso = (tomados / total);
  }
}

class Alarme {
  final String hora;
  final String nome;
  final String dose;
  final bool tomado;
  final bool ativo;

  Alarme({
    required this.hora,
    required this.nome,
    required this.dose,
    required this.tomado,
    required this.ativo,
  });

  Alarme copyWith({bool? tomado, bool? ativo}) {
    return Alarme(
      hora: hora,
      nome: nome,
      dose: dose,
      tomado: tomado ?? this.tomado,
      ativo: ativo ?? this.ativo,
    );
  }
}
