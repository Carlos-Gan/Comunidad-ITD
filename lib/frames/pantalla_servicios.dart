// ignore_for_file: deprecated_member_use

import 'package:ciit_2/extras/AppColors.dart';
import 'package:flutter/material.dart';

class ServiciosEscolares extends StatefulWidget {
  const ServiciosEscolares({super.key});

  @override
  State<ServiciosEscolares> createState() => _ServiciosEscolaresState();
}

class _ServiciosEscolaresState extends State<ServiciosEscolares> {
  int _citasAgendadas = 3;

  final List<Map<String, dynamic>> _tramitesDisponibles = [
    {'icon': Icons.school, 'title': 'Tramitar beca', 'color': Colors.blue},
    {'icon': Icons.description, 'title': 'Constancia', 'color': Colors.green},
    {'icon': Icons.qr_code, 'title': 'Código barras', 'color': Colors.orange},
    {'icon': Icons.grade, 'title': 'Calificaciones', 'color': Colors.purple},
    {'icon': Icons.credit_card, 'title': 'Créditos', 'color': Colors.red},
    {'icon': Icons.history_edu, 'title': 'Historial', 'color': Colors.teal},
  ];

  final List<Map<String, dynamic>> _inscripciones = [
    {'icon': Icons.calendar_today, 'title': 'Nuevo semestre', 'color': Colors.indigo},
    {'icon': Icons.sports_esports, 'title': 'Extracurricular', 'color': Colors.pink},
    {'icon': Icons.language, 'title': 'Idioma CLEIT', 'color': Colors.amber},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "SERVICIOS ESCOLARES",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        backgroundColor: AppColors.principal,
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Header con estadísticas
            _buildHeaderStats(),

            // Grid de trámites principales
            Expanded(
              flex: 3,
              child: _buildTramitesGrid(),
            ),
            const SizedBox(height: 10),

            // Fila inferior: Citas e Inscripciones
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: _buildCitasCard(),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInscripcionesCard(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button para ayuda rápida
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarAyudaModerno,
        backgroundColor: AppColors.principal,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.help_outline, size: 28),
      ),
    );
  }

  Widget _buildHeaderStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.principal, Colors.purple[400]!],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(Icons.access_time, 'Citas Activas', _citasAgendadas.toString()),
          _buildStatItem(Icons.check_circle, 'Trámites Listos', '5'),
          _buildStatItem(Icons.notifications, 'Pendientes', '2'),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildTramitesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 5),
          child: Text(
            'Trámites Disponibles',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 4,
            ),
            itemCount: _tramitesDisponibles.length,
            itemBuilder: (context, index) {
              return _buildTramiteCard(_tramitesDisponibles[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTramiteCard(Map<String, dynamic> tramite) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _mostrarDetallesTramiteModerno(tramite['title']),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                tramite['color'].withOpacity(0.1),
                tramite['color'].withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: tramite['color'].withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  tramite['icon'],
                  color: tramite['color'],
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  tramite['title'],
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCitasCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[50]!, Colors.blue[100]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.calendar_today, color: Colors.blue, size: 20),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Mis Citas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '$_citasAgendadas activas',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _agendarNuevaCitaModerno,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text(
                    'NUEVA CITA',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInscripcionesCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green[50]!, Colors.green[100]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.app_registration, color: Colors.green, size: 20),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Inscripciones',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: _inscripciones.length,
                  itemBuilder: (context, index) {
                    return _buildInscripcionItem(_inscripciones[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInscripcionItem(Map<String, dynamic> inscripcion) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: inscripcion['color'].withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(inscripcion['icon'], color: inscripcion['color'], size: 16),
      ),
      title: Text(
        inscripcion['title'],
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(Icons.arrow_forward, size: 12, color: Colors.green),
      ),
      onTap: () => _mostrarDetallesInscripcionModerno(inscripcion['title']),
    );
  }

  void _agendarNuevaCitaModerno() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildBottomSheetCitas(),
    );
  }

  Widget _buildBottomSheetCitas() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header del bottomsheet
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Agendar Nueva Cita',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Opciones de citas
            ...['Asesoría Académica', 'Trámite Documental', 'Consulta de Becas', 'Otro Trámite']
                .map((tipo) => _buildOpcionCitaModerno(tipo))
                ,
          ],
        ),
      ),
    );
  }

  Widget _buildOpcionCitaModerno(String tipo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.principal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.calendar_today, color: AppColors.principal, size: 20),
        ),
        title: Text(tipo),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey[300]!),
        ),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            _citasAgendadas++;
          });
          _mostrarConfirmacionCita(tipo);
        },
      ),
    );
  }

  void _mostrarDetallesTramiteModerno(String tramite) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tramite,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Información detallada sobre el trámite seleccionado.'),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _mostrarProcesoTramite(tramite);
                      },
                      child: const Text('Iniciar'),
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

  void _mostrarDetallesInscripcionModerno(String inscripcion) {
    // Similar al de trámites pero para inscripciones
    _mostrarDialogoModerno(inscripcion, 'Inscripción');
  }

  void _mostrarAyudaModerno() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Icon(Icons.help, size: 48, color: AppColors.principal),
              const SizedBox(height: 16),
              const Text(
                'Centro de Ayuda',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoAyuda('📞', '(618) 123-4567'),
              _buildInfoAyuda('📧', 'servicios@ciit.edu'),
              _buildInfoAyuda('🕒', 'L-V 8:00 - 18:00'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Entendido'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoAyuda(String emoji, String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji),
          const SizedBox(width: 12),
          Text(texto),
        ],
      ),
    );
  }

  void _mostrarConfirmacionCita(String tipo) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✅ Cita para $tipo agendada'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _mostrarProcesoTramite(String tramite) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🔄 Iniciando trámite: $tramite'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _mostrarDialogoModerno(String titulo, String tipo) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text('Detalles de la $tipo seleccionada.'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}