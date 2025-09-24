import 'package:ciit_2/extras/AppColors.dart';
import 'package:flutter/material.dart';

class PantallaCESA extends StatelessWidget {
  const PantallaCESA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "CESA",
          style: TextStyle(color: Colors.white),
        ),
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
              // Encabezado de bienvenida
              _buildEncabezado(),
              const SizedBox(height: 25),

              // Sección: Presupuesto Participativo
              _buildSeccionPresupuesto(),
              const SizedBox(height: 25),

              // Sección: Transparencia
              _buildSeccionTransparencia(),
              const SizedBox(height: 25),

              // Sección: Trámites
              _buildSeccionTramites(),
              const SizedBox(height: 25),

              // Sección: Eventos Próximos
              _buildSeccionEventos(),
              const SizedBox(height: 25),

              // Sección: Alertas
              _buildSeccionAlertas(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEncabezado() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.principal,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Column(
        children: [
          Icon(Icons.school, color: Colors.white, size: 50),
          SizedBox(height: 10),
          Text(
            "Bienvenido al CESA, estamos aquí para ti",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSeccionPresupuesto() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la sección
            _buildTituloSeccion("Presupuesto Participativo"),
            const SizedBox(height: 15),
            
            const Text(
              "TOP Propuestas:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),

            // Lista de propuestas
            _buildPropuesta(
              "Domo de Sistemas y Bioquímica",
              "543 votos",
            ),
            _buildPropuesta(
              "Salón para Arquitectura",
              "209 votos",
            ),
            _buildPropuesta(
              "Gimnasio \"BurroTES\"",
              "23 votos",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropuesta(String titulo, String votos) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  votos,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Acción para votar
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.principal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text(
              "VOTAR",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeccionTransparencia() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTituloSeccion("Transparencia"),
            const SizedBox(height: 10),
            const Text(
              "Conoce cómo se utilizan los recursos",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Navegar a transparencia
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("VER DETALLES"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeccionTramites() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTituloSeccion("Realiza tus trámites:"),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildTarjetaTramite(
                    "QR comedor estudiantil",
                    Icons.qr_code,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildTarjetaTramite(
                    "Credencialización foráneos",
                    Icons.badge,
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTarjetaTramite(String titulo, IconData icono, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // Acción del trámite
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icono, color: color, size: 30),
              const SizedBox(height: 8),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeccionEventos() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTituloSeccion("Eventos Próximos"),
            const SizedBox(height: 15),
            _buildItemEventoAlerta(
              "Hakatton",
              "Sistemas",
              "23 de sep a 24 de sep",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeccionAlertas() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTituloSeccion("Alertas"),
            const SizedBox(height: 15),
            _buildItemEventoAlerta(
              "Edificio Sistemas Cerrado",
              "Hakatton - Sistemas",
              "23 de sep a 24 de sep",
              esAlerta: true,
            ),
            _buildItemEventoAlerta(
              "Límite para evaluación docente",
              "Evaluación docente - ITD",
              "28 de sep",
              esAlerta: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemEventoAlerta(String titulo, String subtitulo, String fecha, {bool esAlerta = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: esAlerta ? Colors.red[50] : Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: esAlerta ? Colors.red[200]! : Colors.blue[200]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: esAlerta ? Colors.red[800] : Colors.blue[800],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitulo,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            fecha,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTituloSeccion(String titulo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.principal.withOpacity(0.8),
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
    );
  }
}