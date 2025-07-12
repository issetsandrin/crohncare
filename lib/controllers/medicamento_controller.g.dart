// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicamento_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MedicamentoController on _MedicamentoControllerBase, Store {
  late final _$medicamentosAtom = Atom(
    name: '_MedicamentoControllerBase.medicamentos',
    context: context,
  );

  @override
  List<Medicamento> get medicamentos {
    _$medicamentosAtom.reportRead();
    return super.medicamentos;
  }

  @override
  set medicamentos(List<Medicamento> value) {
    _$medicamentosAtom.reportWrite(value, super.medicamentos, () {
      super.medicamentos = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_MedicamentoControllerBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$medicamentoAtom = Atom(
    name: '_MedicamentoControllerBase.medicamento',
    context: context,
  );

  @override
  String? get medicamento {
    _$medicamentoAtom.reportRead();
    return super.medicamento;
  }

  @override
  set medicamento(String? value) {
    _$medicamentoAtom.reportWrite(value, super.medicamento, () {
      super.medicamento = value;
    });
  }

  late final _$tipoAtom = Atom(
    name: '_MedicamentoControllerBase.tipo',
    context: context,
  );

  @override
  String get tipo {
    _$tipoAtom.reportRead();
    return super.tipo;
  }

  @override
  set tipo(String value) {
    _$tipoAtom.reportWrite(value, super.tipo, () {
      super.tipo = value;
    });
  }

  late final _$dosagemAtom = Atom(
    name: '_MedicamentoControllerBase.dosagem',
    context: context,
  );

  @override
  String? get dosagem {
    _$dosagemAtom.reportRead();
    return super.dosagem;
  }

  @override
  set dosagem(String? value) {
    _$dosagemAtom.reportWrite(value, super.dosagem, () {
      super.dosagem = value;
    });
  }

  late final _$frequenciaAtom = Atom(
    name: '_MedicamentoControllerBase.frequencia',
    context: context,
  );

  @override
  String? get frequencia {
    _$frequenciaAtom.reportRead();
    return super.frequencia;
  }

  @override
  set frequencia(String? value) {
    _$frequenciaAtom.reportWrite(value, super.frequencia, () {
      super.frequencia = value;
    });
  }

  late final _$horariosAtom = Atom(
    name: '_MedicamentoControllerBase.horarios',
    context: context,
  );

  @override
  ObservableList<String> get horarios {
    _$horariosAtom.reportRead();
    return super.horarios;
  }

  @override
  set horarios(ObservableList<String> value) {
    _$horariosAtom.reportWrite(value, super.horarios, () {
      super.horarios = value;
    });
  }

  late final _$comAlimentoAtom = Atom(
    name: '_MedicamentoControllerBase.comAlimento',
    context: context,
  );

  @override
  bool get comAlimento {
    _$comAlimentoAtom.reportRead();
    return super.comAlimento;
  }

  @override
  set comAlimento(bool value) {
    _$comAlimentoAtom.reportWrite(value, super.comAlimento, () {
      super.comAlimento = value;
    });
  }

  late final _$estoqueAtualAtom = Atom(
    name: '_MedicamentoControllerBase.estoqueAtual',
    context: context,
  );

  @override
  int get estoqueAtual {
    _$estoqueAtualAtom.reportRead();
    return super.estoqueAtual;
  }

  @override
  set estoqueAtual(int value) {
    _$estoqueAtualAtom.reportWrite(value, super.estoqueAtual, () {
      super.estoqueAtual = value;
    });
  }

  late final _$prescritoPorAtom = Atom(
    name: '_MedicamentoControllerBase.prescritoPor',
    context: context,
  );

  @override
  String? get prescritoPor {
    _$prescritoPorAtom.reportRead();
    return super.prescritoPor;
  }

  @override
  set prescritoPor(String? value) {
    _$prescritoPorAtom.reportWrite(value, super.prescritoPor, () {
      super.prescritoPor = value;
    });
  }

  late final _$dataInicioAtom = Atom(
    name: '_MedicamentoControllerBase.dataInicio',
    context: context,
  );

  @override
  DateTime? get dataInicio {
    _$dataInicioAtom.reportRead();
    return super.dataInicio;
  }

  @override
  set dataInicio(DateTime? value) {
    _$dataInicioAtom.reportWrite(value, super.dataInicio, () {
      super.dataInicio = value;
    });
  }

  late final _$observacoesAtom = Atom(
    name: '_MedicamentoControllerBase.observacoes',
    context: context,
  );

  @override
  String? get observacoes {
    _$observacoesAtom.reportRead();
    return super.observacoes;
  }

  @override
  set observacoes(String? value) {
    _$observacoesAtom.reportWrite(value, super.observacoes, () {
      super.observacoes = value;
    });
  }

  late final _$carregarMedicamentosAsyncAction = AsyncAction(
    '_MedicamentoControllerBase.carregarMedicamentos',
    context: context,
  );

  @override
  Future<void> carregarMedicamentos() {
    return _$carregarMedicamentosAsyncAction.run(
      () => super.carregarMedicamentos(),
    );
  }

  late final _$adicionarMedicamentoAsyncAction = AsyncAction(
    '_MedicamentoControllerBase.adicionarMedicamento',
    context: context,
  );

  @override
  Future<void> adicionarMedicamento(Map<String, dynamic> medicamento) {
    return _$adicionarMedicamentoAsyncAction.run(
      () => super.adicionarMedicamento(medicamento),
    );
  }

  late final _$atualizarMedicamentoAsyncAction = AsyncAction(
    '_MedicamentoControllerBase.atualizarMedicamento',
    context: context,
  );

  @override
  Future<void> atualizarMedicamento(Medicamento medicamento) {
    return _$atualizarMedicamentoAsyncAction.run(
      () => super.atualizarMedicamento(medicamento),
    );
  }

  late final _$removerMedicamentoAsyncAction = AsyncAction(
    '_MedicamentoControllerBase.removerMedicamento',
    context: context,
  );

  @override
  Future<void> removerMedicamento(int id) {
    return _$removerMedicamentoAsyncAction.run(
      () => super.removerMedicamento(id),
    );
  }

  late final _$_MedicamentoControllerBaseActionController = ActionController(
    name: '_MedicamentoControllerBase',
    context: context,
  );

  @override
  void resetForm() {
    final _$actionInfo = _$_MedicamentoControllerBaseActionController
        .startAction(name: '_MedicamentoControllerBase.resetForm');
    try {
      return super.resetForm();
    } finally {
      _$_MedicamentoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
medicamentos: ${medicamentos},
isLoading: ${isLoading},
medicamento: ${medicamento},
tipo: ${tipo},
dosagem: ${dosagem},
frequencia: ${frequencia},
horarios: ${horarios},
comAlimento: ${comAlimento},
estoqueAtual: ${estoqueAtual},
prescritoPor: ${prescritoPor},
dataInicio: ${dataInicio},
observacoes: ${observacoes}
    ''';
  }
}
