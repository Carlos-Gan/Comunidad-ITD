import 'package:ciit_2/extras/AppColors.dart';
import 'package:flutter/material.dart';

class QuejasSugerencias extends StatefulWidget {
  const QuejasSugerencias({super.key});

  @override
  State<QuejasSugerencias> createState() => _QuejasSugerenciasState();
}

class _QuejasSugerenciasState extends State<QuejasSugerencias> {
  int _seleccionActual = 0; // 0: Quejas, 1: Sugerencias
  final TextEditingController _controladorQuejas = TextEditingController();
  final TextEditingController _controladorSugerencias = TextEditingController();

  @override
  void dispose() {
    _controladorQuejas.dispose();
    _controladorSugerencias.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "QUEJAS Y SUGERENCIAS",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.principal,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        color: AppColors.terciario,
        child: Column(
          children: [
            // Selector de tipo (Quejas/Sugerencias)
            _buildSelectorTipo(),
            
            // Área de texto según la selección
            Expanded(
              child: _buildAreaTexto(),
            ),
            
            // Botón ENVIAR
            _buildBotonEnviar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectorTipo() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: _buildBotonTipo(
                  texto: "QUEJAS",
                  seleccionado: _seleccionActual == 0,
                  onTap: () {
                    setState(() {
                      _seleccionActual = 0;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildBotonTipo(
                  texto: "SUGERENCIAS",
                  seleccionado: _seleccionActual == 1,
                  onTap: () {
                    setState(() {
                      _seleccionActual = 1;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBotonTipo({
    required String texto,
    required bool seleccionado,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: seleccionado ? AppColors.principal : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: seleccionado ? AppColors.principal : Colors.grey[300]!,
          ),
        ),
        child: Text(
          texto,
          style: TextStyle(
            color: seleccionado ? Colors.white : Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAreaTexto() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _seleccionActual == 0 ? "Describe tu queja:" : "Describe tu sugerencia:",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: TextField(
                  controller: _seleccionActual == 0 
                      ? _controladorQuejas 
                      : _controladorSugerencias,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: _seleccionActual == 0
                        ? "Escribe aquí tu queja..."
                        : "Escribe aquí tu sugerencia...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.principal),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBotonEnviar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _enviarFormulario,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.principal,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
          ),
          child: const Text(
            "ENVIAR",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _enviarFormulario() {
    final texto = _seleccionActual == 0 
        ? _controladorQuejas.text.trim()
        : _controladorSugerencias.text.trim();

    if (texto.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _seleccionActual == 0 
                ? "Por favor escribe tu queja"
                : "Por favor escribe tu sugerencia",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Simular envío
    _mostrarDialogoConfirmacion();
  }

  void _mostrarDialogoConfirmacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 60,
          ),
          content: Text(
            _seleccionActual == 0
                ? "¡Queja enviada exitosamente!"
                : "¡Sugerencia enviada exitosamente!",
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _limpiarFormulario();
              },
              child: const Text(
                "Aceptar",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  void _limpiarFormulario() {
    setState(() {
      if (_seleccionActual == 0) {
        _controladorQuejas.clear();
      } else {
        _controladorSugerencias.clear();
      }
    });
  }
}