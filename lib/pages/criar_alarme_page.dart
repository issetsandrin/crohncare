import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_doenca_crohn/controllers/alarme_controller.dart';
import '../models/alarme.dart';
import 'selecionar_medicamento_sheet.dart';

class CriarAlarmePage extends StatefulWidget {
  const CriarAlarmePage({Key? key}) : super(key: key);

  @override
  State<CriarAlarmePage> createState() => _CriarAlarmePageState();
}

class _CriarAlarmePageState extends State<CriarAlarmePage> {
  Future<void> _showCustomTimePicker() async {
    int selectedHour = _hora.hour;
    int selectedMinute = _hora.minute;
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SizedBox(
          height: 320,
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Text(
                'Selecione o horário',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem: selectedHour,
                        ),
                        itemExtent: 50,
                        onSelectedItemChanged: (value) {
                          selectedHour = value;
                        },
                        children: List.generate(
                          24,
                          (i) => Center(
                            child: Text(
                              i.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem: selectedMinute,
                        ),
                        itemExtent: 50,
                        onSelectedItemChanged: (value) {
                          selectedMinute = value;
                        },
                        children: List.generate(
                          60,
                          (i) => Center(
                            child: Text(
                              i.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF0052D4),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Color(0xFF0052D4),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: DecoratedBox(
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
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _hora = TimeOfDay(
                                  hour: selectedHour,
                                  minute: selectedMinute,
                                );
                              });
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Alterar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  AlarmeController controller = Modular.get<AlarmeController>();

  TimeOfDay _hora = const TimeOfDay(hour: 6, minute: 0);
  String? _medicamentoSelecionado = 'Azatioprina';
  final TextEditingController _dosagemController = TextEditingController(
    text: '2 comprimidos',
  );
  List<bool> _diasSelecionados = List.generate(7, (_) => false);
  String? _somSelecionado = 'Beep Clássico';
  final List<String> _sonsMockados = [
    'Beep Clássico',
    'Alarme Digital',
    'Sino Suave',
    'Toque Moderno',
    'Vibração',
  ];
  bool _alarmeAtivo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Move all your form widgets here (previously inside the first body)
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 320,
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
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 100),
                          GestureDetector(
                            onTap: _showCustomTimePicker,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Horário do Alarme',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 55,
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    _hora.format(context),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Toque para alterar o horário',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    // Botão de voltar
                    Positioned(
                      top: 0,
                      left: 10,
                      child: SafeArea(
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          tooltip: 'Voltar',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                    left: 12,
                    right: 12,
                    top: 5,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 22,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Color(0xFFE3E8F0), width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F0FE),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.notifications_none,
                                color: Color(0xFF4D7CFE),
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Repetir nos dias',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: List.generate(7, (i) {
                          final labels = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
                          final bool selected = _diasSelecionados[i];
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: GestureDetector(
                              onTap: () => setState(
                                () => _diasSelecionados[i] = !selected,
                              ),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                width: 40,
                                height: 35,
                                decoration: BoxDecoration(
                                  gradient: selected
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFF0052D4),
                                            Color(0xFF4364F7),
                                            Color(0xFF6FB1FC),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : null,
                                  color: selected
                                      ? null
                                      : const Color.fromARGB(65, 211, 211, 211),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                      123,
                                      255,
                                      255,
                                      255,
                                    ),
                                    width: 1.0,
                                  ),
                                  boxShadow: [
                                    if (!selected)
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 6,
                                        offset: const Offset(0, 1),
                                      ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  labels[i],
                                  style: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : const Color(0xFF222B45),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    left: 12,
                    right: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE3E8F0),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6FAEA),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.medication,
                                color: Color(0xFF2ECC8B),
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Medicamento',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Nome do medicamento',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          final selecionado =
                              await showModalBottomSheet<String>(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) =>
                                    SelecionarMedicamentoSheet(
                                      selecionado: _medicamentoSelecionado,
                                      onSelecionar: (nome) =>
                                          Navigator.of(context).pop(nome),
                                    ),
                              );
                          if (selecionado != null) {
                            setState(
                              () => _medicamentoSelecionado = selecionado,
                            );
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Selecione o medicamento',
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF8FAFF),
                              prefixIcon: const Icon(
                                Icons.medication_outlined,
                                color: Color(0xFF296CFF),
                              ),
                            ),
                            style: const TextStyle(fontSize: 15),
                            controller: TextEditingController(
                              text: _medicamentoSelecionado ?? '',
                            ),
                            readOnly: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Dosagem',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _dosagemController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF8FAFF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFFE3E8F0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFFE3E8F0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFF2ECC8B),
                              width: 1.5,
                            ),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    left: 12,
                    right: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE3E8F0),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3E8FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.volume_up,
                                color: Color(0xFF9B51E0),
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Som do Alarme',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () async {
                          final selecionado =
                              await showModalBottomSheet<String>(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => SafeArea(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(18),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 0,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 5,
                                            margin: const EdgeInsets.only(
                                              bottom: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 24,
                                            vertical: 4,
                                          ),
                                          child: Text(
                                            'Selecione o som do alarme',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        ..._sonsMockados.map(
                                          (item) => ListTile(
                                            leading: Icon(
                                              item == 'Beep Clássico'
                                                  ? Icons.notifications
                                                  : item == 'Alarme Digital'
                                                  ? Icons.alarm
                                                  : item == 'Sino Suave'
                                                  ? Icons.notifications_active
                                                  : item == 'Toque Moderno'
                                                  ? Icons.music_note
                                                  : item == 'Vibração'
                                                  ? Icons.vibration
                                                  : Icons.volume_up,
                                              color: item == _somSelecionado
                                                  ? Color(0xFF296CFF)
                                                  : Colors.grey,
                                            ),
                                            title: Text(item),
                                            trailing: item == _somSelecionado
                                                ? Container(
                                                    width: 17,
                                                    height: 17,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF296CFF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                    child: const Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                  )
                                                : null,
                                            onTap: () =>
                                                Navigator.of(context).pop(item),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                          if (selecionado != null) {
                            setState(() => _somSelecionado = selecionado);
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Selecione o som do alarme',
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF8FAFF),
                              prefixIcon: const Icon(
                                Icons.volume_up,
                                color: Color(0xFF9B51E0),
                              ),
                            ),
                            style: const TextStyle(fontSize: 15),
                            controller: TextEditingController(
                              text: _somSelecionado ?? '',
                            ),
                            readOnly: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    left: 12,
                    right: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE3E8F0),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6FAEA),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                color: Color(0xFF2ECC8B),
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Alarme Ativo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 1.2,
                        child: Switch(
                          value: _alarmeAtivo,
                          onChanged: (v) => setState(() => _alarmeAtivo = v),
                          activeTrackColor: const Color(0xFF6FB1FC),
                          activeColor: const Color(0xFF0052D4),
                          inactiveThumbColor: Colors.grey.shade300,
                          inactiveTrackColor: Colors.grey.shade200,
                        ),
                      ),
                    ],
                  ),
                ),
                // ...existing code...
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              color: Colors.transparent,
              child: SizedBox(
                width: double.infinity,
                child: DecoratedBox(
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
                  child: ElevatedButton(
                    onPressed: () async {
                      final novoAlarme = Alarme(
                        nomeMedicamento: _medicamentoSelecionado ?? '',
                        dosagem: _dosagemController.text,
                        hora: _hora.format(context),
                        dias: List<bool>.from(_diasSelecionados),
                        som: _somSelecionado ?? '',
                        ativo: _alarmeAtivo,
                      );
                      await controller.cadastrarAlarme(novoAlarme);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Alarme cadastrado com sucesso!'),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Salvar Alarme',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
