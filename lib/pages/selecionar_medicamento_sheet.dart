import 'package:flutter/material.dart';

class SelecionarMedicamentoSheet extends StatelessWidget {
  final List<_MedicamentoItem> medicamentos = const [
    _MedicamentoItem('Mesalazina', Icons.medication, Color(0xFF296CFF)),
    _MedicamentoItem('Azatioprina', Icons.medication, Color(0xFF296CFF)),
    _MedicamentoItem('Prednisona', Icons.medication, Color(0xFF296CFF)),
  ];

  final String? selecionado;
  final ValueChanged<String> onSelecionar;

  const SelecionarMedicamentoSheet({
    super.key,
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
                'Selecione um medicamento',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            ...medicamentos.map(
              (item) => ListTile(
                leading: Icon(item.icon, color: item.color),
                title: Text(item.nome),
                trailing: selecionado == item.nome
                    ? Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                          color: Color(0xFF296CFF),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        ),
                      )
                    : null,
                onTap: () {
                  onSelecionar(item.nome);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicamentoItem {
  final String nome;
  final IconData icon;
  final Color color;
  const _MedicamentoItem(this.nome, this.icon, this.color);
}
