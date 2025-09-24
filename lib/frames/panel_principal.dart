import 'package:ciit_2/extras/AppColors.dart';
import 'package:ciit_2/frames/pantalla_carrera.dart';
import 'package:ciit_2/frames/pantalla_cesa.dart';
import 'package:ciit_2/frames/pantalla_servicios.dart';
import 'package:ciit_2/frames/pantalla_usuarios.dart';
import 'package:ciit_2/frames/sistema_citas.dart';
import 'package:flutter/material.dart';

class PanelPrincipal extends StatefulWidget {
  const PanelPrincipal({super.key});

  @override
  State<PanelPrincipal> createState() => _PanelPrincipalState();
}

class _PanelPrincipalState extends State<PanelPrincipal> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String nombre = "Jose Jose";

  // Datos de eventos y alertas
  final List<Map<String, dynamic>> eventos = [
    {
      'nombre': 'Hackathon 2024',
      'carrera': 'Ing. Sistemas',
      'fecha': '23 de Sep - 24 de Sep',
      'color': Colors.amber,
      'icon': Icons.code_rounded,
      'tipo': 'evento',
      'leido': false,
    },
    {
      'nombre': 'Simposium Tecnológico',
      'carrera': 'ITD',
      'fecha': '20 de Sep - 26 de Sep',
      'color': Colors.green,
      'icon': Icons.people_rounded,
      'tipo': 'evento',
      'leido': true,
    },
    {
      'nombre': 'Elecciones CESA',
      'carrera': 'Todas las carreras',
      'fecha': '05 de Oct',
      'color': Colors.blue,
      'icon': Icons.how_to_vote_rounded,
      'tipo': 'evento',
      'leido': false,
    },
  ];

  final List<Map<String, dynamic>> alertas = [
    {
      'titulo': 'Edificio Sistemas Cerrado',
      'causa': 'Hackathon 2024',
      'carrera': 'Sistemas',
      'fecha': '23 de Sep - 24 de Sep',
      'color': Colors.red,
      'icon': Icons.warning_rounded,
      'tipo': 'alerta',
      'leido': false,
      'urgente': true,
    },
    {
      'titulo': 'Límite para evaluación docente',
      'causa': 'Evaluación docente',
      'carrera': 'ITD',
      'fecha': '28 de Sep',
      'color': Colors.orange,
      'icon': Icons.timer_rounded,
      'tipo': 'alerta',
      'leido': true,
      'urgente': false,
    },
    {
      'titulo': 'Suspensión de clases',
      'causa': 'Mantenimiento eléctrico',
      'carrera': 'Todas las carreras',
      'fecha': '15 de Oct',
      'color': Colors.purple,
      'icon': Icons.power_off_rounded,
      'tipo': 'alerta',
      'leido': false,
      'urgente': true,
    },
  ];

  // Contador de notificaciones no leídas
  int get _contadorNotificaciones {
    return eventos.where((e) => e['leido'] == false).length +
        alertas.where((a) => a['leido'] == false).length;
  }

  void _marcarComoLeido(int index, String tipo) {
    setState(() {
      if (tipo == 'evento') {
        eventos[index]['leido'] = true;
      } else {
        alertas[index]['leido'] = true;
      }
    });
  }

  void _marcarTodosComoLeidos() {
    setState(() {
      for (var evento in eventos) {
        evento['leido'] = true;
      }
      for (var alerta in alertas) {
        alerta['leido'] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[50],
      endDrawer: _buildNotificationsDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con bienvenida
            _buildHeader(nombre, context),

            // Contenido principal
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Itinerario Semanal
                  _buildItinerarioSemanal(),
                  const SizedBox(height: 30),

                  // Sección principal con Accesos Rápidos y Mis Espacios
                  _buildMainContent(context),
                  const SizedBox(height: 30),

                  // Poli-IA Section
                  _buildPoliIASection(context),
                  const SizedBox(height: 30),

                  // Resumen de Eventos y Alertas (solo preview)
                  _buildPreviewEventsAlerts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String nombre, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.principal,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
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
                    "¡Que tengas un excelente día!",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PantallaUsuario(
                              nombre: nombre,
                              correo: "example@gmail.com",
                              carrera: "Sistemas",
                              fechaRegistro: "Hoy",
                            ),
                      ),
                    );
                  },
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                      },
                    ),
                    if (_contadorNotificaciones > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            _contadorNotificaciones.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
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
          ],
        ),
      ),
    );
  }

  // Drawer de Notificaciones
  Widget _buildNotificationsDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header del Drawer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 60,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: AppColors.principal,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Notificaciones",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Tienes $_contadorNotificaciones notificaciones nuevas",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                if (_contadorNotificaciones > 0)
                  TextButton(
                    onPressed: _marcarTodosComoLeidos,
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    child: const Text("Marcar todas como leídas"),
                  ),
              ],
            ),
          ),

          // Contenido del Drawer
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  // Pestañas
                  Container(
                    color: Colors.grey[50],
                    child: TabBar(
                      labelColor: AppColors.principal,
                      unselectedLabelColor: Colors.grey[600],
                      indicatorColor: AppColors.principal,
                      tabs: const [
                        Tab(
                          text: "Eventos",
                          icon: Icon(Icons.event_rounded, size: 20),
                        ),
                        Tab(
                          text: "Alertas",
                          icon: Icon(Icons.warning_rounded, size: 20),
                        ),
                      ],
                    ),
                  ),

                  // Contenido de las pestañas
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Pestaña de Eventos
                        _buildEventosTab(),

                        // Pestaña de Alertas
                        _buildAlertasTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventosTab() {
    if (eventos.isEmpty) {
      return const Center(child: Text("No hay eventos por el momento"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: eventos.length,
      itemBuilder: (context, index) {
        final evento = eventos[index];
        return _buildNotificacionItem(
          titulo: evento['nombre'] as String,
          subtitulo: evento['carrera'] as String,
          fecha: evento['fecha'] as String,
          color: evento['color'] as Color,
          icon: evento['icon'] as IconData,
          leido: evento['leido'] as bool,
          urgente: false,
          onTap: () => _marcarComoLeido(index, 'evento'),
        );
      },
    );
  }

  Widget _buildAlertasTab() {
    if (alertas.isEmpty) {
      return const Center(child: Text("No hay alertas por el momento"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: alertas.length,
      itemBuilder: (context, index) {
        final alerta = alertas[index];
        return _buildNotificacionItem(
          titulo: alerta['titulo'] as String,
          subtitulo: alerta['causa'] as String,
          fecha: alerta['fecha'] as String,
          color: alerta['color'] as Color,
          icon: alerta['icon'] as IconData,
          leido: alerta['leido'] as bool,
          urgente: alerta['urgente'] as bool,
          onTap: () => _marcarComoLeido(index, 'alerta'),
        );
      },
    );
  }

  Widget _buildNotificacionItem({
    required String titulo,
    required String subtitulo,
    required String fecha,
    required Color color,
    required IconData icon,
    required bool leido,
    required bool urgente,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: leido ? Colors.white : color.withOpacity(0.05),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          titulo,
          style: TextStyle(
            fontSize: 14,
            fontWeight: leido ? FontWeight.normal : FontWeight.w600,
            color: leido ? Colors.grey[600] : Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitulo),
            Text(
              fecha,
              style: TextStyle(fontSize: 11, color: Colors.grey[500]),
            ),
          ],
        ),
        trailing:
            !leido
                ? Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                )
                : null,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  // Preview de eventos y alertas en el main content
  Widget _buildPreviewEventsAlerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Resumen de Actividades",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            // Preview Eventos
            Expanded(
              child: GestureDetector(
                onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.event_rounded,
                            color: Colors.blue[700],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Eventos Próximos",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${eventos.length} eventos programados",
                        style: TextStyle(color: Colors.blue[800]),
                      ),
                      Text(
                        "${eventos.where((e) => e['leido'] == false).length} sin leer",
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            // Preview Alertas
            Expanded(
              child: GestureDetector(
                onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning_rounded,
                            color: Colors.orange[700],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Alertas",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${alertas.length} alertas activas",
                        style: TextStyle(color: Colors.orange[800]),
                      ),
                      Text(
                        "${alertas.where((a) => a['leido'] == false).length} sin leer",
                        style: TextStyle(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Haz clic en cualquier tarjeta o en el icono de campana para ver todas las notificaciones",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  // Resto de los métodos permanecen iguales (sin cambios)
  Widget _buildItinerarioSemanal() {
    final Map<String, Map<String, dynamic>> diasSemana = {
      'Lunes': {'tareas': 2, 'eventos': 1, 'clases': true, 'icon': Icons.work},
      'Martes': {
        'tareas': 0,
        'eventos': 3,
        'clases': true,
        'icon': Icons.school,
      },
      'Miércoles': {
        'tareas': 1,
        'eventos': 0,
        'clases': true,
        'icon': Icons.assignment,
      },
      'Jueves': {
        'tareas': 0,
        'eventos': 0,
        'clases': false,
        'icon': Icons.beach_access,
      },
      'Viernes': {
        'tareas': 4,
        'eventos': 2,
        'clases': true,
        'icon': Icons.weekend,
      },
      'Sábado': {
        'tareas': 0,
        'eventos': 1,
        'clases': false,
        'icon': Icons.celebration,
      },
      'Domingo': {
        'tareas': 0,
        'eventos': 0,
        'clases': false,
        'icon': Icons.restaurant,
      },
    };

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

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      diasSemana.entries.map((entry) {
                        final dia = entry.key;
                        final datos = entry.value;
                        return _buildDiaItem(
                          dia: dia,
                          icon: datos['icon'] as IconData,
                          tieneClases: datos['clases'] as bool,
                          tareas: datos['tareas'] as int,
                          eventos: datos['eventos'] as int,
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDiaItem({
    required String dia,
    required IconData icon,
    required bool tieneClases,
    required int tareas,
    required int eventos,
  }) {
    final totalActividades = tareas + eventos;
    final esHoy = dia == 'Lunes';

    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: esHoy ? AppColors.principal.withOpacity(0.1) : Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: esHoy ? AppColors.principal : Colors.grey[300]!,
          width: esHoy ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dia.substring(0, 3),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: esHoy ? AppColors.principal : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Icon(
            icon,
            color: esHoy ? AppColors.principal : Colors.grey[600],
            size: 24,
          ),
          const SizedBox(height: 8),
          if (totalActividades > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                totalActividades.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            Text(
              tieneClases ? "Clases" : "Libre",
              style: TextStyle(fontSize: 10, color: Colors.grey[500]),
            ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildSection(
            title: "🚀 Accesos Rápidos",
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.3,
              shrinkWrap: true,
              children: [
                _buildAccessItem(
                  Icons.assignment_rounded,
                  "Tareas Pendientes",
                  "5 pendientes",
                  Colors.blue,
                  badgeCount: 5,
                ),
                _buildAccessItem(
                  Icons.schedule_rounded,
                  "Mi Horario",
                  "Ver horario semanal",
                  Colors.green,
                ),
                _buildAccessItem(
                  Icons.grade_rounded,
                  "Mis Calificaciones",
                  "Ver calificaciones",
                  Colors.orange,
                ),
                _buildAccessItem(
                  Icons.calendar_today_rounded,
                  "Seguimiento de Solicitudes",
                  "2 solicitudes activas",
                  Colors.purple,
                  badgeCount: 2,
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SistemaCitas(),
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: _buildSection(
            title: "🏠 Mis Espacios",
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.2,
              shrinkWrap: true,
              children: [
                _buildSpaceItem(
                  Icons.dashboard_rounded,
                  "Mi Espacio",
                  "Área personal",
                  Colors.indigo,
                ),
                _buildSpaceItem(
                  Icons.account_balance_rounded,
                  "CESA",
                  "Centro de estudiantes",
                  Colors.teal,
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PantallaCESA(),
                        ),
                      ),
                ),
                _buildSpaceItem(
                  Icons.school_rounded,
                  "Servicios Escolares",
                  "Trámites académicos",
                  Colors.blueGrey,
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ServiciosEscolares(),
                        ),
                      ),
                ),
                _buildSpaceItem(
                  Icons.engineering_rounded,
                  "Mi Carrera",
                  "Ing. Sistemas",
                  Colors.deepOrange,
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => const PantallaCarrera(
                                nombreCarrera: 'Sistemas',
                                descripcion:
                                    'Ingeniería en Sistemas Computacionales',
                                cursos: [
                                  "CISCO",
                                  "POO",
                                  "Base de Datos",
                                  "Redes",
                                ],
                                convocatorias: [
                                  "HACKATHON",
                                  "PRÁCTICAS PROFESIONALES",
                                ],
                              ),
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPoliIASection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.purple[50]!, Colors.blue[50]!],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.smart_toy_rounded, color: Colors.purple, size: 28),
              const SizedBox(width: 10),
              const Text(
                "¿Dudas? Pregúntale a Poli-IA!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            "Asistente inteligente para resolver tus dudas sobre:\n• Planes de estudio • Horarios • Requisitos • Trámites",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _abrirPoliIA(context),
            icon: Icon(Icons.chat_rounded, size: 20),
            label: const Text("Abrir Poli-IA"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildAccessItem(
    IconData icon,
    String title,
    String subtitle,
    Color color, {
    int badgeCount = 0,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: color, size: 32),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              if (badgeCount > 0)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      badgeCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpaceItem(
    IconData icon,
    String title,
    String subtitle,
    Color color, {
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _abrirPoliIA(BuildContext context) {
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
                  Icon(Icons.smart_toy_rounded, size: 60, color: Colors.purple),
                  const SizedBox(height: 15),
                  const Text(
                    "Poli-IA - Asistente Virtual",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Próximamente podrás hacer preguntas sobre tu carrera, materias, horarios y más.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                    ),
                    child: const Text("Entendido"),
                  ),
                ],
              ),
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
