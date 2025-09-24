import 'package:ciit_2/extras/AppColors.dart';
import 'package:flutter/material.dart';

class PantallaCarrera extends StatelessWidget {
  final String nombreCarrera;
  final String descripcion;
  final List<String> cursos;
  final List<String> convocatorias;

  const PantallaCarrera({
    super.key,
    required this.nombreCarrera,
    required this.descripcion,
    required this.cursos,
    required this.convocatorias,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MI CARRERA", style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.principal,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        color: AppColors.terciario,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título principal de la carrera
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.principal,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  nombreCarrera,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              // Sección: VIDA LABORAL
              _buildSeccion(
                titulo: "VIDA LABORAL",
                contenido: Text(
                  descripcion,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                color: Colors.blue,
              ),
              const SizedBox(height: 20),

              // Sección: CURSOS Y MATERIAL DE APOYO
              _buildSeccion(
                titulo: "CURSOS Y MATERIAL DE APOYO",
                contenido: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      cursos.map((curso) => _buildItemLista(curso)).toList(),
                ),
                color: Colors.green,
              ),
              const SizedBox(height: 20),

              // Sección: CONVOCATORIAS
              _buildSeccion(
                titulo: "CONVOCATORIAS",
                contenido: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      convocatorias
                          .map((convocatoria) => _buildItemLista(convocatoria))
                          .toList(),
                ),
                color: Colors.red,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeccion({
    required String titulo,
    required Widget contenido,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la sección
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Contenido de la sección
            contenido,
          ],
        ),
      ),
    );
  }

  Widget _buildItemLista(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(child: Text(texto, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildCodigoLine(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        texto,
        style: TextStyle(
          fontFamily: 'Monospace',
          fontSize: 14,
          color: Colors.grey[800],
          backgroundColor: Colors.grey[200],
        ),
      ),
    );
  }
}
