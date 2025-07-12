import 'package:flutter/material.dart';

class Medicamento {
  final int? id;
  final String nome;
  final String tipo;
  final Color tipoCor;
  final String dose;
  final String medico;
  final List<String> horarios;
  final String observacao;
  final String quantidade;
  final String observacaoFinal;
  final DateTime? dataInicio;

  Medicamento({
    this.id,
    required this.nome,
    required this.tipo,
    required this.tipoCor,
    required this.dose,
    required this.medico,
    required this.horarios,
    required this.observacao,
    required this.quantidade,
    required this.observacaoFinal,
    this.dataInicio,
  });

  factory Medicamento.fromMap(Map<String, dynamic> map) {
    return Medicamento(
      id: map['id'] as int?,
      nome: map['nome'] ?? '',
      tipo: map['tipo'] ?? 'Outro',
      tipoCor: map['tipoCor'] is int
          ? Color(map['tipoCor'])
          : const Color(0xFFB000B5),
      dose: map['dose'] ?? '',
      medico: map['medico'] ?? '',
      horarios: map['horarios'] != null
          ? List<String>.from(map['horarios'])
          : <String>[],
      observacao: map['observacao'] ?? '',
      quantidade: map['quantidade'] ?? '',
      observacaoFinal: map['observacaoFinal'] ?? '',
      dataInicio: map['dataInicio'] != null && map['dataInicio'] is String
          ? DateTime.tryParse(map['dataInicio'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tipo': tipo,
      'tipoCor': tipoCor.value,
      'dose': dose,
      'medico': medico,
      'horarios': horarios,
      'observacao': observacao,
      'quantidade': quantidade,
      'observacaoFinal': observacaoFinal,
      'dataInicio': dataInicio?.toIso8601String(),
    };
  }
}
