import 'package:ciit_2/extras/AppColors.dart';
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
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ), // ícono de ejemplo
            onPressed: () {
              // TODO: Acción al presionar el botón
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Panel izquierdo
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // <-- alineado a la izquierda
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
                      onChanged: (value) {
                        print("Buscando: $value");
                      },
                      onSubmitted: (value) {
                        print("Texto final: $value");
                      },
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Título del itinerario alineado a la izquierda
                  const Text(
                    "Itinerario Semanal",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  // Itinerario visual
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
                        //
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Lunes"),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Martes"),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Miercoles"),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Jueves"),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Viernes"),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sabado"),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade600,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Domingo"),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade600,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  //Columnas de Acceso Rapido y Mis Espacios
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Acceso Rapido"),
                          Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                              color: AppColors.secundario,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                              color: AppColors.principal,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Mis espacios"),
                          Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              color: AppColors.secundario,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Panel de eventos y alertas
          Container(
            width: 300,
            color: AppColors.terciario,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Eventos",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  EventosWidget(
                    nombreEvento: "Maratón CDMX",
                    nombreCarrera: "10K Categoría Libre",
                    fecha: "23/09/2025",
                  ),
                  SizedBox(height: 16),
                  EventosWidget(
                    nombreEvento: "Carrera Universitaria",
                    nombreCarrera: "5K Categoría Estudiantes",
                    fecha: "30/09/2025",
                  ),
                  SizedBox(height: 16),
                  EventosWidget(
                    nombreEvento: "Carrera Recreativa",
                    nombreCarrera: "3K Familiar",
                    fecha: "05/10/2025",
                  ),
                  SizedBox(height: 16),
                  EventosWidget(
                    nombreEvento: "Competencia Profesional",
                    nombreCarrera: "21K Elite",
                    fecha: "12/10/2025",
                  ),
                  SizedBox(height: 16),
                  EventosWidget(
                    nombreEvento: "Competencia Pro",
                    nombreCarrera: "21 Elite",
                    fecha: "12/10",
                  ),
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
}
