// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remedios_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RemediosStore on _RemediosStoreBase, Store {
  late final _$remediosAtom = Atom(
    name: '_RemediosStoreBase.remedios',
    context: context,
  );

  @override
  ObservableList<Remedio> get remedios {
    _$remediosAtom.reportRead();
    return super.remedios;
  }

  @override
  set remedios(ObservableList<Remedio> value) {
    _$remediosAtom.reportWrite(value, super.remedios, () {
      super.remedios = value;
    });
  }

  late final _$_RemediosStoreBaseActionController = ActionController(
    name: '_RemediosStoreBase',
    context: context,
  );

  @override
  void adicionarRemedio(Remedio remedio) {
    final _$actionInfo = _$_RemediosStoreBaseActionController.startAction(
      name: '_RemediosStoreBase.adicionarRemedio',
    );
    try {
      return super.adicionarRemedio(remedio);
    } finally {
      _$_RemediosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removerRemedio(int index) {
    final _$actionInfo = _$_RemediosStoreBaseActionController.startAction(
      name: '_RemediosStoreBase.removerRemedio',
    );
    try {
      return super.removerRemedio(index);
    } finally {
      _$_RemediosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
remedios: ${remedios}
    ''';
  }
}
