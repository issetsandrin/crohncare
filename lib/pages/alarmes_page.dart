import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../controllers/alarme_controller.dart';
import 'criar_alarme_page.dart';

class AlarmesPage extends StatefulWidget {
  AlarmesPage({super.key});

  @override
  State<AlarmesPage> createState() => _AlarmesPageState();
}

class _AlarmesPageState extends State<AlarmesPage> {
  final AlarmeController controller = Modular.get<AlarmeController>();

  @override
  void initState() {
    super.initState();
    controller.carregarAlarmes();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Alarmes',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Container(
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
                  onPressed: () async {
                    // Abre a página de cadastro e recarrega alarmes ao voltar
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => CriarAlarmePage()),
                    );
                    controller.carregarAlarmes();
                  },
                  icon: const Icon(Icons.alarm, color: Colors.white, size: 20),
                  label: const Text(
                    'Cadastrar Alarme',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    minimumSize: const Size(0, 37),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(child: _buildAlarmesList(controller)),
      ],
    );
  }

  Widget _buildAlarmesList(AlarmeController controller) {
    final diasLabels = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
    return Observer(
      builder: (_) {
        if (controller.alarmes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.alarm_off, size: 48, color: Color(0xFF7B8FA1)),
                const SizedBox(height: 16),
                const Text(
                  'Nenhum alarme cadastrado',
                  style: TextStyle(fontSize: 16, color: Color(0xFF7B8FA1)),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.alarmes.length,
          itemBuilder: (context, index) {
            final alarme = controller.alarmes[index];
            return Card(
              color: alarme.ativo ? Colors.white : const Color(0xFFF3F7FF),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: alarme.ativo
                      ? const Color(0xFF0052D4).withOpacity(0.3)
                      : const Color(0xFFB0B0B0).withOpacity(0.2),
                  width: 1,
                ),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 18,
                ),
                child: Opacity(
                  opacity: alarme.ativo ? 1.0 : 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  alarme.nomeMedicamento,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF3A4750),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  alarme.hora,
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF232323),
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Switch(
                                value: alarme.ativo,
                                onChanged: (v) {},
                                activeColor: const Color(0xFF0052D4),
                                activeTrackColor: const Color(0xFF6FB1FC),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Color(0xFF7B8FA1),
                                  size: 20,
                                ),
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      titlePadding: const EdgeInsets.fromLTRB(
                                        24,
                                        24,
                                        24,
                                        0,
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                        24,
                                        12,
                                        24,
                                        0,
                                      ),
                                      actionsPadding: const EdgeInsets.fromLTRB(
                                        16,
                                        8,
                                        16,
                                        16,
                                      ),
                                      title: Row(
                                        children: [
                                          const Icon(
                                            Icons.delete_outline,
                                            color: Colors.red,
                                            size: 26,
                                          ),
                                          const SizedBox(width: 8),
                                          const Text(
                                            'Confirmar Exclusão',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: const Text(
                                        'Deseja realmente deletar este item? Esta ação não pode ser desfeita.',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(false),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.black,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 22,
                                                      vertical: 10,
                                                    ),
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  side: const BorderSide(
                                                    color: Colors.black12,
                                                  ),
                                                ),
                                              ),
                                              child: const Text('Cancelar'),
                                            ),
                                            const SizedBox(width: 8),
                                            ElevatedButton.icon(
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(true),
                                              icon: const Icon(
                                                Icons.delete_outline,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                              label: const Text('Sim, Deletar'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 18,
                                                      vertical: 10,
                                                    ),
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirm == true && alarme.id != null) {
                                    await controller.removerAlarme(alarme.id!);
                                  }
                                },
                                tooltip: 'Excluir',
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: List.generate(alarme.dias.length, (i) {
                          final ativo = alarme.dias[i];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              gradient: ativo
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
                              color: ativo ? null : const Color(0xFFF3F7FF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              diasLabels[i],
                              style: TextStyle(
                                color: ativo
                                    ? Colors.white
                                    : const Color(0xFF7B8FA1),
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.volume_up,
                            size: 18,
                            color: Color(0xFF7B8FA1),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            alarme.som,
                            style: const TextStyle(
                              color: Color(0xFF7B8FA1),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
