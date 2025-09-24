import 'package:flutter/material.dart';

class EventosWidget extends StatelessWidget {
  final String nombreEvento;
  final String nombreCarrera;
  final String fecha;
  final Widget? logo; // Opcional: puedes pasar un widget como logo

  const EventosWidget({
    super.key,
    required this.nombreEvento,
    required this.nombreCarrera,
    required this.fecha,
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 120,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Logo o widget opcional
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: logo ?? const Icon(
                  Icons.event,
                ),
              ),

              const SizedBox(width: 12),

              // Información del evento
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nombreEvento,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nombreCarrera,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      fecha,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
