import 'package:ciit_2/extras/AppColors.dart';
import 'package:flutter/material.dart';

class SistemaCitas extends StatefulWidget {
  const SistemaCitas({super.key});

  @override
  State<SistemaCitas> createState() => _SistemaCitasState();
}

class _SistemaCitasState extends State<SistemaCitas> {
  int _currentFrame = 0; // 0: Estatus, 1: Agendar, 2: Confirmación
  String _departamentoSeleccionado = 'Centro de información';
  DateTime? _fechaSeleccionada;
  String _lugarCita = '';

  final List<String> _departamentos = [
    'Centro de información',
    'Servicios escolares',
    'Biblioteca',
    'Departamento académico',
    'Orientación vocacional'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SISTEMA DE CITAS",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.principal,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        color: AppColors.terciario,
        child: _buildCurrentFrame(),
      ),
    );
  }

  Widget _buildCurrentFrame() {
    switch (_currentFrame) {
      case 0:
        return _buildFrameEstatus();
      case 1:
        return _buildFrameAgendar();
      case 2:
        return _buildFrameConfirmacion();
      default:
        return _buildFrameEstatus();
    }
  }

  // Frame 4: ESTATUS DE CITA
  Widget _buildFrameEstatus() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título principal
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.principal,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              "ESTATUS DE CITA",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),

          // Botón para solicitar cita
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: const Icon(Icons.add_circle_outline, color: Colors.blue),
              title: const Text(
                "Solicitar cita",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                setState(() {
                  _currentFrame = 1;
                });
              },
            ),
          ),
          const SizedBox(height: 20),

          // Sección de cita programada
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Estado PENDIENTE
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "PENDIENTE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  const Text(
                    "Fecha de la cita:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _fechaSeleccionada != null 
                        ? _formatearFecha(_fechaSeleccionada!)
                        : "No programada",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  
                  const Text(
                    "Lugar de la cita:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _lugarCita.isNotEmpty ? _lugarCita : "No especificado",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Frame 5: AGENDAR CITA
  Widget _buildFrameAgendar() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título principal
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.principal,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              "AGENDAR CITA",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),

          // Selección de departamento
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Elige el departamento:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: _departamentoSeleccionado,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    items: _departamentos.map((departamento) {
                      return DropdownMenuItem(
                        value: departamento,
                        child: Text(departamento),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _departamentoSeleccionado = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Selección de fecha
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Elige la fecha:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: _seleccionarFecha,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[50],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.blue),
                          const SizedBox(width: 10),
                          Text(
                            _fechaSeleccionada != null
                                ? _formatearFecha(_fechaSeleccionada!)
                                : "Seleccionar fecha",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Botón AGENDAR CITA
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _agendarCita,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.principal,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "AGENDAR CITA",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Frame de confirmación
  Widget _buildFrameConfirmacion() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 20),
            const Text(
              "¡CITA AGENDADA EXITOSAMENTE!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildInfoConfirmacion("Departamento:", _departamentoSeleccionado),
                    _buildInfoConfirmacion("Fecha:", _formatearFecha(_fechaSeleccionada!)),
                    _buildInfoConfirmacion("Lugar:", _lugarCita),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentFrame = 0;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.principal,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "VOLVER AL INICIO",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoConfirmacion(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              titulo,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              valor,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    
    if (picked != null) {
      setState(() {
        _fechaSeleccionada = picked;
        _lugarCita = "Edificio principal - $_departamentoSeleccionado";
      });
    }
  }

  void _agendarCita() {
    if (_fechaSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor selecciona una fecha")),
      );
      return;
    }

    setState(() {
      _currentFrame = 2; // Ir a frame de confirmación
    });
  }

  String _formatearFecha(DateTime fecha) {
    return "${fecha.day}/${fecha.month}/${fecha.year}";
  }
}