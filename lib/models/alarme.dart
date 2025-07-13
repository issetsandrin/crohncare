class Alarme {
  int? id;
  String nomeMedicamento;
  String dosagem;
  String hora;
  List<bool> dias;
  String som;
  bool ativo;

  Alarme({
    this.id,
    required this.nomeMedicamento,
    required this.dosagem,
    required this.hora,
    required this.dias,
    required this.som,
    required this.ativo,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'nome': nomeMedicamento,
    'dosagem': dosagem,
    'horario': hora,
    'dias': dias.map((e) => e ? 1 : 0).join(','),
    'som': som,
    'ativo': ativo ? 1 : 0,
    'remedio': nomeMedicamento,
  };

  factory Alarme.fromMap(Map<String, dynamic> map) => Alarme(
    id: map['id'],
    nomeMedicamento: map['nome'] ?? map['remedio'] ?? '',
    dosagem: map['dosagem'] ?? '',
    hora: map['horario'] ?? '',
    dias: (map['dias'] as String? ?? '')
        .split(',')
        .map((e) => e == '1')
        .toList(),
    som: map['som'] ?? '',
    ativo: map['ativo'] == 1,
  );
}
