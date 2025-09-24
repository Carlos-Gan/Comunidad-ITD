import 'package:ciit_2/extras/AppColors.dart';
import 'package:ciit_2/frames/profesor/asignar_tarea.dart';
import 'package:ciit_2/frames/profesor/ver_clases.dart';
import 'package:flutter/material.dart';

class PanelMaestros extends StatefulWidget {
  const PanelMaestros({super.key});

  @override
  State<PanelMaestros> createState() => _PanelMaestrosState();
}

class _PanelMaestrosState extends State<PanelMaestros> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String nombre = "Profr. Juan Pérez";

  // Ejemplo de actividades semanales
  final Map<String, Map<String, dynamic>> diasSemana = {
    'Lunes': {
      'clases': 2,
      'tareas': 1,
      'evaluaciones': 0,
      'icon': Icons.menu_book,
    },
    'Martes': {
      'clases': 3,
      'tareas': 0,
      'evaluaciones': 1,
      'icon': Icons.assignment,
    },
    'Miércoles': {
      'clases': 1,
      'tareas': 2,
      'evaluaciones': 0,
      'icon': Icons.school,
    },
    'Jueves': {'clases': 2, 'tareas': 0, 'evaluaciones': 0, 'icon': Icons.work},
    'Viernes': {
      'clases': 3,
      'tareas': 1,
      'evaluaciones': 1,
      'icon': Icons.grade,
    },
    'Sábado': {
      'clases': 0,
      'tareas': 0,
      'evaluaciones': 0,
      'icon': Icons.beach_access,
    },
    'Domingo': {
      'clases': 0,
      'tareas': 0,
      'evaluaciones': 0,
      'icon': Icons.restaurant,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      key: _scaffoldKey,
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildItinerarioSemanal(),
            const SizedBox(height: 30),
            _buildMainContent(context),
            const SizedBox(height: 30),
            _buildReportesSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.principal,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bienvenido, $nombre",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Panel de gestión docente",
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () => _confirmarCerrarSesion(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItinerarioSemanal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "📅 Itinerario Semanal",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                diasSemana.entries.map((entry) {
                  final dia = entry.key;
                  final datos = entry.value;
                  final total =
                      (datos['clases'] as int) +
                      (datos['tareas'] as int) +
                      (datos['evaluaciones'] as int);
                  return Container(
                    width: 110,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey[300]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          dia.substring(0, 3),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Icon(datos['icon'], color: AppColors.principal),
                        const SizedBox(height: 8),
                        Text(
                          "$total actividades",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "🚀 Accesos Rápidos",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 15),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 4,
          children: [
            _buildAccessItem(
              Icons.menu_book,
              "Ver Clases",
              "Listado de asignaturas",
              Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VerClasesDemo()),
                );
              },
            ),
            _buildAccessItem(
              Icons.assignment_rounded,
              "Asignar Tareas",
              "Crear y publicar",
              Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AsignarTareaScreen()),
                );
              },
            ),
            _buildAccessItem(
              Icons.grade,
              "Calificar Alumnos",
              "Registrar calificaciones",
              Colors.orange,
            ),
            _buildAccessItem(
              Icons.schedule,
              "Mi Horario",
              "Ver horario docente",
              Colors.purple,
            ),
          ],
        ),
        const SizedBox(height: 30),
        const Text(
          "🏫 Mis Espacios",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 15),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 3.5,
          children: [
            _buildAccessItem(
              Icons.dashboard,
              "Mis Cursos",
              "Gestión académica",
              Colors.indigo,
            ),
            _buildAccessItem(
              Icons.account_balance,
              "Coordinación",
              "Centro académico",
              Colors.teal,
            ),
            _buildAccessItem(
              Icons.school,
              "Gestión Escolar",
              "Trámites académicos",
              Colors.blueGrey,
            ),
            _buildAccessItem(
              Icons.bar_chart,
              "Reportes",
              "Generar informes",
              Colors.deepOrange,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReportesSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: const [
          Icon(Icons.insights, color: Colors.blue, size: 28),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Consulta reportes de desempeño académico, asistencia y evaluaciones.",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccessItem(
    IconData icon,
    String title,
    String subtitle,
    Color color, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap, // ← ahora recibe la acción
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: color,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmarCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout_rounded, size: 50, color: Colors.red),
                  const SizedBox(height: 15),
                  const Text(
                    "Cerrar sesión",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "¿Estás seguro de que quieres salir?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Cancelar"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Salir"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
