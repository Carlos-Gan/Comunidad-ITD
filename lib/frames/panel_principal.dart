import 'package:ciit_2/extras/AppColors.dart';
import 'package:flutter/material.dart';

class PanelPrincipal extends StatelessWidget {
  const PanelPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    String nombre = "Jose";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bienvenido, $nombre",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.principal,
        automaticallyImplyLeading: false, // Oculta el back automático
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            _confirmarCerrarSesion(context);
          },
        ),
      ),
      body: const Center(
        child: Text("Contenido principal"),
      ),
    );
  }

  void _confirmarCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cerrar sesión",),
        content: const Text("¿Estás seguro de que quieres cerrar sesión?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cierra el diálogo
            child: const Text("Cancelar", style: TextStyle(color: Colors.black),),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo
              Navigator.pop(context); // Regresa a la pantalla anterior
              // Aquí podrías limpiar datos de sesión si es necesario
            },
            child: const Text("Sí, salir", style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
    );
  }
}
