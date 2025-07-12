import 'package:flutter/material.dart';

class ConsultasPage extends StatelessWidget {
  const ConsultasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final consultas = [
      {
        "icone": Icons.medical_services,
        "iconeCor": Color(0xFF296CFF),
        "titulo": "Dr. Silva",
        "subtitulo": "Gastroenterologia",
        "data": "14/01/2025",
        "hora": "14:30",
        "local": "Hospital São Lucas - Sala 205",
        "observacao": "Consulta de rotina - levar exames recentes",
      },
      {
        "icone": Icons.description,
        "iconeCor": Color(0xFF4CAF50),
        "titulo": "Laboratório Central",
        "subtitulo": "Análises Clínicas",
        "data": "09/01/2025",
        "hora": "07:00",
        "local": "Lab Central - Unidade Centro",
        "preparo": "Jejum de 12 horas",
        "exames": "Hemograma completo, PCR, VHS",
      },
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Consultas',
              style: const TextStyle(
                fontSize: 24, // alterado para 24px
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: consultas.length,
            itemBuilder: (context, index) {
              final consulta = consultas[index];
              return Container(
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
                              color: (consulta["iconeCor"] as Color)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              consulta["icone"] as IconData,
                              color: consulta["iconeCor"] as Color,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  consulta["titulo"] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  consulta["subtitulo"] as String,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            consulta["data"] as String,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            consulta["hora"] as String,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        consulta["local"] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      if (consulta.containsKey("observacao"))
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            consulta["observacao"] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      if (consulta.containsKey("preparo"))
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF9E5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Preparo: ",
                                    style: TextStyle(
                                      color: Color(0xFFB88A00),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  TextSpan(
                                    text: consulta["preparo"] as String,
                                    style: const TextStyle(
                                      color: Color(0xFFB88A00),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (consulta.containsKey("exames"))
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            consulta["exames"] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
