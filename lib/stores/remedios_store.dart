import 'package:mobx/mobx.dart';

part 'remedios_store.g.dart';

class Remedio {
  final String nome;
  final String dose;

  Remedio({required this.nome, required this.dose});
}

class RemediosStore = _RemediosStoreBase with _$RemediosStore;

abstract class _RemediosStoreBase with Store {
  @observable
  ObservableList<Remedio> remedios = ObservableList<Remedio>();

  @action
  void adicionarRemedio(Remedio remedio) {
    remedios.add(remedio);
  }

  @action
  void removerRemedio(int index) {
    remedios.removeAt(index);
  }
}
