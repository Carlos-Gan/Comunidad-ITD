import 'package:flutter/material.dart';
import '../extras/AppColors.dart';
import 'panel_principal.dart';

class PanelInicio extends StatefulWidget {
  const PanelInicio({super.key});

  @override
  State<PanelInicio> createState() => _PanelInicioState();
}

class _PanelInicioState extends State<PanelInicio> {
  String? selectedForm;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comunidad ITD", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.principal,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),

              // Icono moderno
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.principal.withOpacity(0.9),
                      AppColors.principal.withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.principal.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 60,
                ),
              ),

              const SizedBox(height: 20),

              // Botones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        selectedForm = "register";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.principal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 5,
                    ),
                    icon: const Icon(Icons.app_registration),
                    label: const Text(
                      "Registrarse",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        selectedForm = "login";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.principal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 5,
                    ),
                    icon: const Icon(Icons.login),
                    label: const Text(
                      "Iniciar Sesión",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Animación de formulario
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child:
                    selectedForm == null
                        ? const SizedBox.shrink()
                        : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width *
                                0.2, // 10% de los lados
                          ),
                          child: Column(
                            key: ValueKey(selectedForm),
                            children: [
                              if (selectedForm == "login") ...[
                                SizedBox(height: 10),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Usuario",
                                    prefixIcon: const Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                //Contraseña
                                TextFormField(
                                  obscureText: _obscure,
                                  decoration: InputDecoration(
                                    labelText: 'Contraseña',
                                    prefixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscure =
                                              !_obscure; // alterna visibilidad
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'La contraseña es obligatoria';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const PanelPrincipal(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.principal,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(
                                      double.infinity,
                                      48,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text("Entrar"),
                                ),
                              ],
                              if (selectedForm == "register") ...[
                                SizedBox(height: 10),
                                //Nombre
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Nombre",
                                    prefixIcon: const Icon(Icons.badge),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                //Usuario
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Usuario",
                                    prefixIcon: const Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                //Numero de Control
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Número de control",
                                    prefixIcon: const Icon(Icons.numbers),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                //Correo
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Correo",
                                    prefixIcon: const Icon(Icons.email),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                //Contraseña
                                TextFormField(
                                  obscureText: _obscure,
                                  decoration: InputDecoration(
                                    labelText: 'Contraseña',
                                    prefixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscure =
                                              !_obscure; // alterna visibilidad
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'La contraseña es obligatoria';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const PanelPrincipal(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.principal,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(
                                      double.infinity,
                                      48,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text("Registrar"),
                                ),
                              ],
                            ],
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
