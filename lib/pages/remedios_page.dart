import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_doenca_crohn/controllers/medicamento_controller.dart';
import 'package:minha_doenca_crohn/models/medicamento.dart';
import 'novo_medicamento_sheet.dart';
import '../database_helper.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RemediosPage extends StatefulWidget {
  const RemediosPage({super.key});

  @override
  State<RemediosPage> createState() => _RemediosPageState();
}

class _RemediosPageState extends State<RemediosPage> {
  final List<Map<String, dynamic>> remedios = [];
  final DatabaseHelper dbHelper = DatabaseHelper();
  final MedicamentoController medicamentoController =
      Modular.get<MedicamentoController>();

  @override
  void initState() {
    super.initState();
    medicamentoController.carregarMedicamentos();
  }

  void _abrirNovoMedicamentoSheet(BuildContext context) async {
    await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: NovoMedicamentoSheet(
          onSalvar: (medicamento) async {
            await medicamentoController.adicionarMedicamento(medicamento);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
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
                    'Remédios',
                    style: TextStyle(
                      fontSize: 24, // alterado para 24px
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
                  onPressed: () => _abrirNovoMedicamentoSheet(context),
                  icon: const Icon(
                    Icons.medication,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: const Text(
                    'Cadastrar Remédio',
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
        Expanded(
          child: Observer(
            builder: (_) {
              return medicamentoController.medicamentos.isEmpty
                  ? Container(
                      color: const Color(0xFFE5E5E5),
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.medical_services_rounded,
                              size: 48,
                              color: const Color(0xFF90A4AE),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Nenhum medicamento cadastrado',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF7B8FA1),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: medicamentoController.medicamentos.length,
                      itemBuilder: (context, index) {
                        Medicamento remedio =
                            medicamentoController.medicamentos[index];
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color:
                                                (remedio.tipoCor as Color?)
                                                    ?.withOpacity(0.1) ??
                                                Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: Icon(
                                            Icons.medication,
                                            color: remedio.tipoCor,
                                            size: 28,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    remedio.nome ?? '',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 2,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      remedio.tipo ?? '',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                remedio.dose ?? '',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                "Por: ${remedio.medico ?? ""}",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                        ...remedio.horarios
                                            .map<Widget>(
                                              (h) => _buildRemedioTag(h),
                                            )
                                            .toList(),
                                        if (remedio.horarios.isEmpty)
                                          GestureDetector(
                                            onTap: () {
                                              // lógica para adicionar horário
                                            },
                                            child: _buildRemedioTag(
                                              'Adicionar horário',
                                              color: Colors.blue.shade50,
                                              textColor: Colors.blue,
                                            ),
                                          ),
                                        if (remedio.observacao.isNotEmpty)
                                          _buildRemedioTag(remedio.observacao),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    _buildRemedioTag(
                                      remedio.quantidade,
                                      color: Colors.grey.shade200,
                                      textColor: Colors.black87,
                                    ),
                                    if (remedio.observacaoFinal.isNotEmpty)
                                      _buildRemedioTag(remedio.observacaoFinal),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              right: 15,
                              child: GestureDetector(
                                onTap: () async {
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
                                  if (confirm == true && remedio.id != null) {
                                    await medicamentoController
                                        .removerMedicamento(remedio.id!);
                                    setState(() {});
                                  }
                                },
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.grey,
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRemedioTag(String text, {Color? color, Color? textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color ?? const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: textColor ?? Colors.black87,
        ),
      ),
    );
  }
}
