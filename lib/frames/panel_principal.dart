import 'package:ciit_2/extras/AppColors.dart';
import 'package:ciit_2/frames/pantalla_carrera.dart';
import 'package:ciit_2/frames/pantalla_cesa.dart';
import 'package:ciit_2/frames/pantalla_usuarios.dart';
import 'package:ciit_2/frames/quejas_sugerencias.dart';
import 'package:ciit_2/frames/sistema_citas.dart';
import 'package:ciit_2/widgets/eventos.dart';
import 'package:flutter/material.dart';

class PanelPrincipal extends StatelessWidget {
  const PanelPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    String nombre = "Jose Jose";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bienvenido, $nombre",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.principal,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            _confirmarCerrarSesion(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
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
        ],
      ),
      body: Row(
        children: [
          // Panel izquierdo scrollable
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SearchBar
                    SizedBox(
                      width: double.infinity,
                      child: SearchBar(
                        leading: const Icon(Icons.search),
                        hintText: "Buscar . . .",
                        elevation: MaterialStateProperty.all(2),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.grey[200],
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        hintStyle: MaterialStateProperty.all(
                          const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        trailing: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.mic, color: Colors.black54),
                          ),
                        ],
                        onChanged: (value) => print("Buscando: $value"),
                        onSubmitted: (value) => print("Texto final: $value"),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Itinerario Semanal
                    const Text(
                      "Itinerario Semanal",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.secundario,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _diaItinerario("Lunes"),
                          _diaItinerario("Martes"),
                          _diaItinerario("Miércoles"),
                          _diaItinerario("Jueves"),
                          _diaItinerario("Viernes"),
                          _diaItinerario("Sábado", color: Colors.grey.shade600),
                          _diaItinerario(
                            "Domingo",
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Acceso Rápido y Mis Espacios
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Acceso Rápido
                        Expanded(
                          child: Column(
                            children: [
                              const Text("Acceso Rápido"),
                              const SizedBox(height: 10),
                              Container(
                                height: 250,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.secundario,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _iconItem(
                                          Icons.book,
                                          "Tareas Pendientes",
                                        ),
                                        _iconItem(
                                          Icons.calendar_month,
                                          "Mi Horario",
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _iconItem(
                                          Icons.grade,
                                          "Mis Calificaciones",
                                        ),
                                        GestureDetector(
                                          child: _iconItem(
                                            Icons.search,
                                            "Solicitudes",
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        const SistemaCitas(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                height: 30,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.principal,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "Dudas? Preguntale a PolaIA!!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Mis Espacios
                        Expanded(
                          child: Column(
                            children: [
                              const Text("Mis espacios"),
                              const SizedBox(height: 10),
                              Container(
                                height: 300,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.secundario,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _iconItem(
                                          Icons.space_dashboard,
                                          "Mi Espacio",
                                        ),
                                        GestureDetector(
                                          child: _iconItem(Icons.money, "CESA"),
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: 
                                            (context)=> const PantallaCESA()));
                                          },
                                        ),
                                        _iconItem(
                                          Icons.switch_account_outlined,
                                          "Servicios Escolares",
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (
                                                      context,
                                                    ) => const PantallaCarrera(
                                                      nombreCarrera: 'Sistemas',
                                                      descripcion: 'La mejor',
                                                      cursos: ["CISCO", "POO"],
                                                      convocatorias: [
                                                        "HACKAThON",
                                                      ],
                                                    ),
                                              ),
                                            );
                                          },
                                          child: _iconItem(
                                            Icons.school,
                                            "Mi Carrera",
                                          ),
                                        ),
                                        _iconItem(
                                          Icons.people,
                                          "Perfil Público",
                                        ),
                                        GestureDetector(
                                          child: _iconItem(
                                            Icons.warning,
                                            "Quejas y\nSugerencias",
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        const QuejasSugerencias(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Panel derecho de eventos
          Container(
            width: 300,
            color: AppColors.terciario,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Eventos",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const EventosWidget(
                    nombreEvento: "Hackaton 2025",
                    nombreCarrera: "Ing. Sistemas Computacionales",
                    fecha: "23/09/2025",
                  ),
                  const SizedBox(height: 16),
                  const EventosWidget(
                    nombreEvento: "Simposium 2025",
                    nombreCarrera: "Ing. Sistemas Computacionales",
                    fecha: "20/09/2025 - 26/09/2025",
                  ),
                  const SizedBox(height: 16),
                  const EventosWidget(
                    nombreEvento: "Elecciones CESA",
                    nombreCarrera: "ITD",
                    fecha: "05/10/2025",
                  ),
                  const SizedBox(height: 16),
                  const EventosWidget(
                    nombreEvento: "Evaluación Docente",
                    nombreCarrera: "ITD",
                    fecha: "12/10/2025",
                  ),
                  const SizedBox(height: 16),
                  const EventosWidget(
                    nombreEvento: "Inicio de 2das Oportunidades",
                    nombreCarrera: "Ing. Sistemas Computacionales",
                    fecha: "12/11/2025",
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmarCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Cerrar sesión"),
            content: const Text("¿Estás seguro de que quieres cerrar sesión?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Sí, salir",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  // Helper widgets
  Widget _iconItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(icon, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 80,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _diaItinerario(String dia, {Color color = Colors.black}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(dia),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }
}
