import 'package:ciit_2/extras/AppColors.dart';
import 'package:flutter/material.dart';

class PantallaUsuario extends StatelessWidget {
  final String nombre;
  final String correo;
  final String carrera;
  final String fechaRegistro;

  const PantallaUsuario({
    super.key,
    required this.nombre,
    required this.correo,
    required this.carrera,
    required this.fechaRegistro,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mi espacio",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.principal,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        color: AppColors.terciario,
        child: Column(
          children: [
            // Encabezado con foto de perfil e información básica
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppColors.principal,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.secundario,
                    child: const Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    nombre,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    carrera,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            // Sección de insignias y puntaje
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoCard("Insignia", "USER", Icons.verified, Colors.amber),
                  _buildInfoCard("PUNTAJE", "10", Icons.leaderboard, Colors.green),
                ],
              ),
            ),
            
            // Grid de opciones principales - AQUÍ ESTÁ EL CAMBIO PRINCIPAL
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 2, // REDUCIDO para cuadrados más pequeños
                  children: [
                    _buildGridItem("DATOS", Icons.person_outline, Colors.blue),
                    _buildGridItem("MIS MATERIAS", Icons.book_outlined, Colors.purple),
                    _buildGridItem("MI HORARIO", Icons.schedule, Colors.orange),
                    _buildGridItem("RETÍCULA", Icons.school, Colors.teal),
                    _buildGridItem("CALIFICACIONES", Icons.grade, Colors.red),
                    _buildGridItem("MIS ACTIVIDADES", Icons.assignment, Colors.indigo),
                    _buildGridItem("Insignias", Icons.emoji_events, Colors.amber),
                    _buildGridItem("MIS CRÉDITOS", Icons.credit_card, Colors.green),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(String title, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // Aquí puedes agregar la navegación para cada opción
        },
        child: Container(
          padding: const EdgeInsets.all(8), // Padding interno reducido
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 30), // Icono más pequeño
              const SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14, // Texto más pequeño
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}