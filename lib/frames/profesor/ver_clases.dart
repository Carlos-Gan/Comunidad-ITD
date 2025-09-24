import 'package:ciit_2/extras/clase.dart';
import 'package:flutter/material.dart';
import 'package:ciit_2/extras/AppColors.dart';

class VerClasesDemo extends StatefulWidget {
  const VerClasesDemo({super.key});

  @override
  State<VerClasesDemo> createState() => _VerClasesDemoState();
}

class _VerClasesDemoState extends State<VerClasesDemo> {
  final List<Clase> _clases = [
    Clase(
      materia: 'Programación Orientada a Objetos',
      profesor: 'Dr. Carlos Rodríguez',
      horario: 'Lunes y Miércoles',
      hora: '07:00 - 08:40',
      aula: 'A-204',
      color: Colors.blue,
      icon: Icons.code_rounded,
    ),
    Clase(
      materia: 'Base de Datos',
      profesor: 'Mtra. Laura García',
      horario: 'Martes y Jueves',
      hora: '09:00 - 10:40',
      aula: 'Lab-301',
      color: Colors.green,
      icon: Icons.storage_rounded,
    ),
    Clase(
      materia: 'Redes de Computadoras',
      profesor: 'Ing. Roberto Silva',
      horario: 'Lunes y Miércoles',
      hora: '11:00 - 12:40',
      aula: 'A-105',
      color: Colors.orange,
      icon: Icons.lan_rounded,
    ),
    Clase(
      materia: 'Matemáticas Discretas',
      profesor: 'Dr. Miguel Ángel Pérez',
      horario: 'Martes y Jueves',
      hora: '13:00 - 14:40',
      aula: 'B-102',
      color: Colors.purple,
      icon: Icons.calculate_rounded,
    ),
    Clase(
      materia: 'Ingeniería de Software',
      profesor: 'Mtra. Ana Martínez',
      horario: 'Viernes',
      hora: '15:00 - 17:40',
      aula: 'Lab-302',
      color: Colors.red,
      icon: Icons.engineering_rounded,
    ),
  ];

  String _diaSeleccionado = 'Lunes';
  final List<String> _diasSemana = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
  ];

  @override
  Widget build(BuildContext context) {
    final clasesDelDia =
        _clases
            .where((clase) => clase.horario.contains(_diaSeleccionado))
            .toList();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Mi Horario de Clases',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.principal,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_rounded, color: Colors.white),
            onPressed: _mostrarCalendarioCompleto,
          ),
          IconButton(
            icon: const Icon(Icons.download_rounded, color: Colors.white),
            onPressed: _descargarHorario,
          ),
        ],
      ),
      body: Column(
        children: [
          // Selector de día - CORREGIDO
          _buildSelectorDia(),

          // Información del día
          _buildInfoDia(clasesDelDia.length),

          // Lista de clases
          Expanded(
            child:
                clasesDelDia.isEmpty
                    ? _buildDiaSinClases()
                    : _buildListaClases(clasesDelDia),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarClaseDemo,
        backgroundColor: AppColors.principal,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildSelectorDia() {
    return Container(
      height: 140, // Aumenté la altura para acomodar el contenido
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _diasSemana.length,
        itemBuilder: (context, index) {
          final dia = _diasSemana[index];
          final esSeleccionado = dia == _diaSeleccionado;
          final tieneClases = _clases.any(
            (clase) => clase.horario.contains(dia),
          );
          final esHoy = dia == 'Lunes';

          return GestureDetector(
            onTap: () => setState(() => _diaSeleccionado = dia),
            child: Container(
              width: 120, // VOLVÍ a 80px que era el tamaño correcto
              margin: EdgeInsets.only(
                left: index == 0 ? 20 : 8,
                right: index == _diasSemana.length - 1 ? 20 : 8,
              ),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    esSeleccionado
                        ? AppColors.principal
                        : esHoy
                        ? AppColors.principal.withOpacity(0.1)
                        : Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      esSeleccionado
                          ? AppColors.principal
                          : esHoy
                          ? AppColors.principal
                          : Colors.grey[300]!,
                  width: esSeleccionado || esHoy ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Número del día
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color:
                            esSeleccionado
                                ? Colors.white
                                : esHoy
                                ? AppColors.principal
                                : Colors.grey[600],
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Nombre del día abreviado
                  Text(
                    _getAbreviaturaDia(dia),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color:
                          esSeleccionado
                              ? Colors.white
                              : esHoy
                              ? AppColors.principal
                              : Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),

                  const SizedBox(height: 4),

                  // Indicador de clases
                  if (tieneClases)
                    Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color:
                            esSeleccionado
                                ? Colors.white.withOpacity(0.2)
                                : Colors.green[50],
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${_clases.where((clase) => clase.horario.contains(dia)).length}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color:
                              esSeleccionado ? Colors.white : Colors.green[700],
                        ),
                      ),
                    )
                  else
                    Icon(
                      Icons.circle_outlined,
                      color: esSeleccionado ? Colors.white : Colors.grey[400],
                      size: 12,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Función para obtener abreviatura del día
  String _getAbreviaturaDia(String diaCompleto) {
    switch (diaCompleto) {
      case 'Lunes':
        return 'LUN';
      case 'Martes':
        return 'MAR';
      case 'Miércoles':
        return 'MIE';
      case 'Jueves':
        return 'JUE';
      case 'Viernes':
        return 'VIE';
      case 'Sábado':
        return 'SAB';
      default:
        return diaCompleto;
    }
  }

  Widget _buildInfoDia(int totalClases) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.principal.withOpacity(0.1),
            AppColors.secundario.withOpacity(0.05),
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.principal,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.schedule_rounded, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _diaSeleccionado,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  totalClases == 0
                      ? 'No hay clases programadas'
                      : '$totalClases ${totalClases == 1 ? 'clase' : 'clases'} programadas',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          if (totalClases > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: Text(
                'Activo',
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ... (el resto de los métodos permanecen igual, solo cambia _buildTarjetaClase)

  Widget _buildTarjetaClase(Clase clase, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => _mostrarDetallesClase(clase),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(color: clase.color.withOpacity(0.2), width: 1),
            ),
            child: Row(
              children: [
                // Icono de la materia - tamaño corregido
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: clase.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(clase.icon, color: clase.color, size: 24),
                ),
                const SizedBox(width: 12),

                // Información de la clase
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clase.materia,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        clase.profesor,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            clase.hora,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.room_rounded,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            clase.aula,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Indicador de estado
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color:
                        _esClaseProxima(clase.hora)
                            ? Colors.green
                            : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _esClaseProxima(String hora) {
    return hora.contains('07:00') || hora.contains('09:00');
  }

  void _mostrarDetallesClase(Clase clase) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: clase.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(clase.icon, color: clase.color, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              clase.materia,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              clase.profesor,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _buildInfoDetalle(
                    'Horario',
                    clase.horario,
                    Icons.calendar_today_rounded,
                  ),
                  _buildInfoDetalle(
                    'Hora',
                    clase.hora,
                    Icons.access_time_rounded,
                  ),
                  _buildInfoDetalle('Aula', clase.aula, Icons.room_rounded),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('Recordatorio'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.principal,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Ubicación'),
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

  Widget _buildInfoDetalle(String titulo, String valor, IconData icono) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icono, color: Colors.grey[500], size: 18),
          const SizedBox(width: 8),
          Text(
            '$titulo: ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          Text(valor, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }

  void _mostrarCalendarioCompleto() {}
  void _descargarHorario() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Horario descargado exitosamente'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _agregarClaseDemo() {
    setState(() {
      _clases.add(
        Clase(
          materia: 'Nueva Materia Demo',
          profesor: 'Profesor Demo',
          horario: _diaSeleccionado,
          hora: '${_clases.length + 8}:00 - ${_clases.length + 9}:40',
          aula: 'Demo-${_clases.length + 1}',
          color: Colors.primaries[_clases.length % Colors.primaries.length],
          icon: Icons.school_rounded,
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Clase demo agregada para $_diaSeleccionado'),
        backgroundColor: AppColors.principal,
      ),
    );
  }

  Widget _buildDiaSinClases() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.beach_access_rounded, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            '¡Día libre!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No tienes clases programadas para $_diaSeleccionado',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _agregarClaseDemo,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Agregar Clase Demo'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.principal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListaClases(List<Clase> clases) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: clases.length,
      itemBuilder: (context, index) {
        final clase = clases[index];
        return _buildTarjetaClase(clase, index);
      },
    );
  }
}
