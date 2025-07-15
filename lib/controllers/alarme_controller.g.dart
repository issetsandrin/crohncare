// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarme_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AlarmeController on _AlarmeControllerBase, Store {
  late final _$alarmesAtom = Atom(
    name: '_AlarmeControllerBase.alarmes',
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

  late final _$isLoadingAtom = Atom(
    name: '_AlarmeControllerBase.isLoading',
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

  late final _$initAsyncAction = AsyncAction(
    '_AlarmeControllerBase.init',
    context: context,
  );

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$removerAlarmeAsyncAction = AsyncAction(
    '_AlarmeControllerBase.removerAlarme',
    context: context,
  );

  @override
  Future<void> removerAlarme(int id) {
    return _$removerAlarmeAsyncAction.run(() => super.removerAlarme(id));
  }

  late final _$carregarAlarmesAsyncAction = AsyncAction(
    '_AlarmeControllerBase.carregarAlarmes',
    context: context,
  );

  @override
  Future<void> carregarAlarmes() {
    return _$carregarAlarmesAsyncAction.run(() => super.carregarAlarmes());
  }

  late final _$cadastrarAlarmeAsyncAction = AsyncAction(
    '_AlarmeControllerBase.cadastrarAlarme',
    context: context,
  );

  @override
  Future<void> cadastrarAlarme(Alarme alarme) {
    return _$cadastrarAlarmeAsyncAction.run(
      () => super.cadastrarAlarme(alarme),
    );
  }

  @override
  String toString() {
    return '''
alarmes: ${alarmes},
isLoading: ${isLoading}
    ''';
  }
}
