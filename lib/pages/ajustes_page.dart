import 'package:flutter/material.dart';

class AjustesPage extends StatefulWidget {
  const AjustesPage({super.key});

  @override
  State<AjustesPage> createState() => _AjustesPageState();
}

class _AjustesPageState extends State<AjustesPage> {
  bool _somAlarme = false;
  bool _vibracao = false;
  bool _soneca = false;
  bool _lembreteEstoque = false;
  bool _consultasProximas = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Ajustes',
              style: const TextStyle(
                fontSize: 24, // alterado para 24px
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.settings, size: 22, color: Colors.black87),
                        SizedBox(width: 8),
                        Text(
                          'Configurações do Alarme',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _ajusteSwitch(
                      title: 'Som do alarme',
                      subtitle: 'Tocar som quando chegar a hora',
                      value: _somAlarme,
                      onChanged: (v) => setState(() => _somAlarme = v),
                    ),
                    _ajusteSwitch(
                      title: 'Vibração',
                      subtitle: 'Vibrar o dispositivo',
                      value: _vibracao,
                      onChanged: (v) => setState(() => _vibracao = v),
                    ),
                    _ajusteSwitch(
                      title: 'Soneca automática',
                      subtitle: 'Permitir adiar por 10 minutos',
                      value: _soneca,
                      onChanged: (v) => setState(() => _soneca = v),
                    ),
                  ],
                ),
              ),
              // Notificações
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Notificações',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _ajusteSwitch(
                      title: 'Lembrete de estoque',
                      subtitle: 'Avisar quando medicamento acabando',
                      value: _lembreteEstoque,
                      onChanged: (v) => setState(() => _lembreteEstoque = v),
                    ),
                    _ajusteSwitch(
                      title: 'Consultas próximas',
                      subtitle: 'Lembrar 1 dia antes',
                      value: _consultasProximas,
                      onChanged: (v) => setState(() => _consultasProximas = v),
                    ),
                  ],
                ),
              ),
              // Informações
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Informações',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.favorite, color: Colors.red, size: 22),
                        SizedBox(width: 8),
                        Text(
                          'CrohnCare',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Versão 1.0.0',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Aplicativo especializado para pacientes com Doença de Crohn',
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ajusteSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF0052D4),
            activeTrackColor: const Color(0xFF6FB1FC),
            inactiveThumbColor: Colors.grey.shade400,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return const Color(0xFF0052D4);
              }
              return Colors.grey.shade400;
            }),
            trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ],
      ),
    );
  }
}
