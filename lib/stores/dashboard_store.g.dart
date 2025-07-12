// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardStore on _DashboardStore, Store {
  late final _$progressoAtom = Atom(
    name: '_DashboardStore.progresso',
    context: context,
  );

  @override
  double get progresso {
    _$progressoAtom.reportRead();
    return super.progresso;
  }

  @override
  set progresso(double value) {
    _$progressoAtom.reportWrite(value, super.progresso, () {
      super.progresso = value;
    });
  }

  late final _$alarmesAtom = Atom(
    name: '_DashboardStore.alarmes',
    context: context,
  );

  @override
  ObservableList<Alarme> get alarmes {
    _$alarmesAtom.reportRead();
    return super.alarmes;
  }

  @override
  set alarmes(ObservableList<Alarme> value) {
    _$alarmesAtom.reportWrite(value, super.alarmes, () {
      super.alarmes = value;
    });
  }

  late final _$_DashboardStoreActionController = ActionController(
    name: '_DashboardStore',
    context: context,
  );

  @override
  void marcarComoTomado(int index) {
    final _$actionInfo = _$_DashboardStoreActionController.startAction(
      name: '_DashboardStore.marcarComoTomado',
    );
    try {
      return super.marcarComoTomado(index);
    } finally {
      _$_DashboardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void marcarComoAtivo(int index, dynamic value) {
    final _$actionInfo = _$_DashboardStoreActionController.startAction(
      name: '_DashboardStore.marcarComoAtivo',
    );
    try {
      return super.marcarComoAtivo(index, value);
    } finally {
      _$_DashboardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
progresso: ${progresso},
alarmes: ${alarmes}
    ''';
  }
}
