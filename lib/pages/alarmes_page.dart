import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/dashboard_store.dart';

class AlarmesPage extends StatelessWidget {
  final DashboardStore store;
  const AlarmesPage({super.key, required this.store});

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
                  onPressed: () => () {},
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
        Expanded(child: _buildAlarmesList()),
      ],
    );
    // ...removido bloco duplicado...
  }

  Widget _buildProgress() {
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            // Remove o border padrão e usa um gradient border
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.transparent, width: 0.1),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 194, 221, 255),
                  Color.fromARGB(255, 125, 181, 249),
                  Color.fromARGB(255, 74, 153, 255),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(2), // largura da borda
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Progresso de Hoje',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '${(store.progresso * 100).toInt()}%',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: store.progresso,
                      backgroundColor: Colors.grey[100],
                      color: const Color.fromARGB(255, 80, 192, 0),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Continue assim!',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlarmesList() {
    // Mock para dias da semana
    String diasSemanaMock(int index) {
      const dias = [
        'SEG TER QUA',
        'QUI SEX',
        'SAB DOM',
        'SEG QUA SEX',
        'TER QUI',
        'DOM',
        'SEG TER QUA QUI SEX SAB DOM',
      ];
      return dias[index % dias.length];
    }

    return Observer(
      builder: (_) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: store.alarmes.length,
        itemBuilder: (context, index) {
          final alarme = store.alarmes[index];
          return Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: const Color(0xFF0052D4).withOpacity(0.3),
                width: 1,
              ),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
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
                              'Azatioprina',
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
                            onChanged: (v) => store.marcarComoAtivo(index, v),
                            activeColor: const Color(0xFF0052D4),
                            activeTrackColor: const Color(0xFF6FB1FC),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Color(0xFF7B8FA1),
                              size: 20,
                            ),
                            onPressed: () {},
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
                    children: List.generate(7, (i) {
                      // DSTQQSS
                      final dias = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
                      final ativo = i < 3; // mock: 3 dias ativos
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
                          dias[i],
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
                    children: const [
                      Icon(Icons.volume_up, size: 18, color: Color(0xFF7B8FA1)),
                      SizedBox(width: 6),
                      Text(
                        'Beep Clássico',
                        style: TextStyle(
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
          );
        },
      ),
    );
  }
}
