import 'package:flutter/material.dart';
import 'dart:convert';
import 'selecionar_medicamento_sheet.dart';

class NovoMedicamentoSheet extends StatefulWidget {
  final void Function(Map<String, dynamic>)? onSalvar;
  const NovoMedicamentoSheet({super.key, this.onSalvar});

  @override
  State<NovoMedicamentoSheet> createState() => _NovoMedicamentoSheetState();
}

class _NovoMedicamentoSheetState extends State<NovoMedicamentoSheet> {
  final _formKey = GlobalKey<FormState>();
  String? _medicamento;
  String? _tipo;
  String? _dosagem;
  String? _frequencia;
  List<String> _horarios = [];
  bool _comAlimento = false;
  int _estoqueAtual = 0;
  String? _prescritoPor;
  DateTime? _dataInicio;
  String? _observacoes;

  final List<String> tipos = ['Outro', 'Comprimido', 'Injetável', 'Líquido'];

  void _adicionarHorario() async {
    if (_horarios.length >= 1) return;
    final TimeOfDay? picked = await showTimePicker(
      cancelText: "Cancelar",
      confirmText: "Selecionar",
      helpText: "Selecione o horário",
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF296CFF), // azul principal
              onPrimary: Colors.white, // texto em cima do azul
              surface: Color(0xFFF3F7FF), // fundo do picker mais claro
              onSurface: Color(0xFF1A237E), // texto/detalhes azul escuro
            ),
            timePickerTheme: const TimePickerThemeData(
              backgroundColor: Color(0xFFF3F7FF), // fundo geral
              hourMinuteColor: Color(0xFFB3CCFF), // caixa hora/min azul claro
              hourMinuteTextColor: Color(
                0xFF1A237E,
              ), // texto hora/min azul escuro
              dayPeriodColor: Color(0xFFB3CCFF), // caixa AM/PM azul claro
              dayPeriodTextColor: Color(0xFF1A237E), // texto AM/PM azul escuro
              dialHandColor: Color(0xFF296CFF), // ponteiro azul principal
              dialBackgroundColor: Color(
                0xFFE3EDFF,
              ), // fundo do dial azul bem claro
              entryModeIconColor: Color(0xFF296CFF), // ícone lápis azul
              helpTextStyle: TextStyle(
                color: Color(0xFF296CFF),
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _horarios.add(picked.format(context));
      });
    }
  }

  void _abrirSelecionarMedicamento() async {
    final selecionado = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelecionarMedicamentoSheet(
        selecionado: _medicamento,
        onSelecionar: (nome) => Navigator.of(context).pop(nome),
      ),
    );
    if (selecionado != null) {
      setState(() => _medicamento = selecionado);
    }
  }

  void _abrirSelecionarTipo() async {
    await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _SelecionarTipoSheet(
        selecionado: _tipo ?? '',
        onSelecionar: (tipo) {
          setState(() => _tipo = tipo);
          Navigator.of(context).pop(); // Fecha o modal ao selecionar
        },
      ),
    );
  }

  String _normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll(RegExp(r'[áàãâä]'), 'a')
        .replaceAll(RegExp(r'[éèêë]'), 'e')
        .replaceAll(RegExp(r'[íìîï]'), 'i')
        .replaceAll(RegExp(r'[óòõôö]'), 'o')
        .replaceAll(RegExp(r'[úùûü]'), 'u')
        .replaceAll(RegExp(r'[ç]'), 'c');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 25,
          right: 25,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Barra de arrastar
              Center(
                child: Container(
                  width: 60,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const Text(
                'Novo Medicamento',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 2),
              const Text(
                'Faça o cadastro de um novo medicamento.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 22),
              GestureDetector(
                onTap: _abrirSelecionarMedicamento,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Medicamento',
                      hintText: 'Selecione um medicamento',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF296CFF),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF296CFF),
                        fontWeight: FontWeight.bold,
                      ),
                      isDense: true,
                      prefixIcon: _medicamento == null
                          ? const Icon(
                              Icons.medication_outlined,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                    controller: TextEditingController(text: _medicamento ?? ''),
                    validator: (value) {
                      if ((_medicamento == null || _medicamento!.isEmpty)) {
                        return 'Selecione um medicamento';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _abrirSelecionarTipo,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Tipo',
                      hintText: 'Selecione o tipo',
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF296CFF),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF296CFF),
                        fontWeight: FontWeight.bold,
                      ),
                      isDense: true,
                      prefixIcon: (_tipo == null)
                          ? const Icon(
                              Icons.category_outlined,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                    controller: TextEditingController(text: _tipo ?? ''),
                    validator: (value) {
                      if (_tipo == null || _tipo!.isEmpty) {
                        return 'Selecione o tipo';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Dosagem',
                        hintText: 'Ex: 800mg',
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF296CFF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xFF296CFF),
                          fontWeight: FontWeight.bold,
                        ),
                        isDense: true,
                        prefixIcon: _dosagem == null
                            ? const Icon(
                                Icons.production_quantity_limits,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      onChanged: (v) => _dosagem = v,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe a dosagem';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Frequência',
                        hintText: 'Ex: 2x ao dia',
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF296CFF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xFF296CFF),
                          fontWeight: FontWeight.bold,
                        ),
                        isDense: true,
                        prefixIcon: _frequencia == null
                            ? const Icon(
                                Icons.schedule_outlined,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      initialValue: _frequencia,
                      onChanged: (v) => _frequencia = v,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe a frequência';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Horários',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Wrap(
                spacing: 8,
                children: [
                  ..._horarios.asMap().entries.map(
                    (entry) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF0052D4),
                            Color(0xFF4364F7),
                            Color(0xFF6FB1FC),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            entry.value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              setState(() => _horarios.removeAt(entry.key));
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_horarios.length < 3)
                    OutlinedButton.icon(
                      onPressed: _adicionarHorario,
                      icon: const Icon(
                        Icons.add,
                        size: 18,
                        color: Color(0xFF296CFF),
                      ),
                      label: const Text(
                        'Adicionar horário',
                        style: TextStyle(color: Color(0xFF296CFF)),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF296CFF)),
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _comAlimento,
                    activeColor: Color(0xFF296CFF), // azul
                    onChanged: (v) => setState(() => _comAlimento = v ?? false),
                  ),
                  const Text('Ingerir com alimentação'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Quantidade prescrita',
                        border: const OutlineInputBorder(),
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF296CFF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xFF296CFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: '',
                      onChanged: (v) => _estoqueAtual = int.tryParse(v) ?? 0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Prescrito por',
                        border: const OutlineInputBorder(),
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF296CFF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xFF296CFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      controller: TextEditingController(
                        text: _prescritoPor ?? '',
                      ),
                      onChanged: (v) => _prescritoPor = v,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Observações',
                  hintText: 'Instruções especiais, efeitos colaterais, etc.',
                  border: const OutlineInputBorder(),
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF296CFF), width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Color(0xFF296CFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                maxLines: 2,
                onChanged: (v) => _observacoes = v,
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF0052D4),
                        Color(0xFF4364F7),
                        Color(0xFF6FB1FC),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final Color corSelecionada;
                        final nomeNorm = _normalize(_medicamento ?? '');
                        if (nomeNorm == 'mesalazina') {
                          corSelecionada = const Color(0xFF296CFF); // Azul
                        } else if (nomeNorm == 'azatioprina') {
                          corSelecionada = const Color(0xFF43A047); // Verde
                        } else if (nomeNorm == 'predinisona') {
                          corSelecionada = const Color(0xFFFFC107); // Amarelo
                        } else {
                          corSelecionada = const Color(0xFFB000B5); // Roxo
                        }
                        final novoMed = {
                          "nome": _medicamento,
                          "tipo": _tipo,
                          "tipoCor": corSelecionada,
                          "dose":
                              (_dosagem != null &&
                                  _frequencia != null &&
                                  _dosagem!.isNotEmpty &&
                                  _frequencia!.isNotEmpty)
                              ? '$_dosagem - $_frequencia'
                              : (_dosagem ?? _frequencia ?? ''),
                          "medico": _prescritoPor ?? '',
                          "horarios": _horarios,
                          "observacao": _comAlimento ? 'Com alimento' : '',
                          "quantidade": _estoqueAtual > 0
                              ? '$_estoqueAtual unidades'
                              : '',
                          "observacaoFinal": _observacoes ?? '',
                        };
                        if (widget.onSalvar != null) {
                          widget.onSalvar!(novoMed);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Adicionar Medicamento',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

// Novo bottom sheet para seleção de tipo
class _SelecionarTipoSheet extends StatelessWidget {
  final List<_TipoItem> tipos = const [
    _TipoItem('Comprimido', Icons.medication, Color(0xFF296CFF)),
    _TipoItem('Injetável', Icons.vaccines, Color(0xFF43A047)),
    _TipoItem('Líquido', Icons.local_drink, Color(0xFFFF9800)),
  ];
  final String selecionado;
  final ValueChanged<String> onSelecionar;

  const _SelecionarTipoSheet({
    required this.selecionado,
    required this.onSelecionar,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de arrastar
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
              child: Text(
                'Selecione o tipo',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            ...tipos.map(
              (tipo) => ListTile(
                leading: Icon(tipo.icon, color: tipo.color),
                title: Text(tipo.nome),
                trailing: selecionado == tipo.nome
                    ? Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                          color: Color(0xFF296CFF),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      )
                    : null,
                onTap: () {
                  onSelecionar(tipo.nome);
                  // Não fecha o bottom sheet!
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TipoItem {
  final String nome;
  final IconData icon;
  final Color color;
  const _TipoItem(this.nome, this.icon, this.color);
}
