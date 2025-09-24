import 'package:ciit_2/extras/AppColors.dart';
import 'package:flutter/material.dart';

class AsignarTareaScreen extends StatefulWidget {
  const AsignarTareaScreen({super.key});

  @override
  State<AsignarTareaScreen> createState() => _AsignarTareaScreenState();
}

class _AsignarTareaScreenState extends State<AsignarTareaScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _cursoSeleccionado;
  String _titulo = "";
  // ignore: unused_field
  String _descripcion = "";
  DateTime? _fechaEntrega;

  final List<String> cursos = [
    "Matemáticas",
    "Historia",
    "Ciencias",
    "Literatura",
  ];

  void _guardarTarea() {
    if (_formKey.currentState!.validate() && _cursoSeleccionado != null) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "📌 Tarea asignada en $_cursoSeleccionado: $_titulo (Entrega: ${_fechaEntrega != null ? "${_fechaEntrega!.day}/${_fechaEntrega!.month}/${_fechaEntrega!.year}" : "Sin fecha"})",
          ),
          backgroundColor: AppColors.principal,
        ),
      );
      // Aquí puedes añadir la lógica para guardar en base de datos o CSV
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📝 Asignar Tarea"),
        backgroundColor: AppColors.principal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selección de curso
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Seleccionar Curso",
                  border: OutlineInputBorder(),
                ),
                items:
                    cursos
                        .map(
                          (curso) => DropdownMenuItem(
                            value: curso,
                            child: Text(curso),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _cursoSeleccionado = value;
                  });
                },
                validator:
                    (value) => value == null ? "Selecciona un curso" : null,
              ),
              const SizedBox(height: 20),

              // Título
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Título de la Tarea",
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Ingresa un título"
                            : null,
                onSaved: (value) => _titulo = value!,
              ),
              const SizedBox(height: 20),

              // Descripción
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Descripción",
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Ingresa una descripción"
                            : null,
                onSaved: (value) => _descripcion = value!,
              ),
              const SizedBox(height: 20),
              const Spacer(),

              // Botón guardar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _guardarTarea,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: AppColors.principal,
                  ),
                  child: const Text(
                    "Guardar Tarea",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
