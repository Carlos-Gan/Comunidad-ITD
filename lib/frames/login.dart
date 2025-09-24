import 'package:ciit_2/frames/profesor/panel_principal_prof.dart';
import 'package:flutter/material.dart';
import '../extras/AppColors.dart';
import 'panel_principal.dart';

class PanelInicio extends StatefulWidget {
  const PanelInicio({super.key});

  @override
  State<PanelInicio> createState() => _PanelInicioState();
}

class _PanelInicioState extends State<PanelInicio>
    with SingleTickerProviderStateMixin {
  String? selectedForm;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final TextEditingController _userController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _userController.dispose();
    super.dispose();
  }

  void _selectForm(String formType) {
    setState(() {
      selectedForm = formType;
    });
    _animationController.forward(from: 0.0);
  }

  void _handleLogin() {
    final username = _userController.text.trim().toLowerCase();

    if (username.isEmpty) {
      _showErrorDialog('Por favor ingresa un usuario');
      return;
    }

    // Redirigir según el tipo de usuario
    if (username == 'est' || username.startsWith('est')) {
      // Usuario estudiante
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder:
              (context, animation, secondaryAnimation) =>
                  const PanelPrincipal(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } else if (username == 'prof' || username.startsWith('prof')) {
      // Usuario profesor
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder:
              (context, animation, secondaryAnimation) =>
                  const PanelMaestros(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } else {
      // Usuario no reconocido - por defecto estudiante
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder:
              (context, animation, secondaryAnimation) =>
                  const PanelPrincipal(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
            
                // Header con logo y título
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        // Logo moderno
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.principal,
                                AppColors.principal.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.principal.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.school_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        const SizedBox(height: 24),
                
                        // Título
                        Text(
                          "Comunidad ITD",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[800],
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Ingresa tu tipo de usuario para continuar",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
            
                const SizedBox(height: 40),
            
                // Selector de formulario con pestañas modernas
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 500),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Pestañas
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildTabButton(
                                    "Iniciar Sesión",
                                    "login",
                                    Icons.login_rounded,
                                  ),
                                ),
                                Expanded(
                                  child: _buildTabButton(
                                    "Modo Demo",
                                    "demo",
                                    Icons.play_arrow_rounded,
                                  ),
                                ),
                              ],
                            ),
                          ),
            
                          // Contenido del formulario
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SizeTransition(
                                  sizeFactor: animation,
                                  child: child,
                                ),
                              );
                            },
                            child:
                                selectedForm == null
                                    ? _buildWelcomeMessage()
                                    : _buildFormContent(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            
                const SizedBox(height: 40),
            
                // Información adicional o footer
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 500),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildInfoItem(
                                Icons.school_rounded,
                                "Estudiante",
                                Colors.blue,
                                "Usa: est",
                              ),
                              _buildInfoItem(
                                Icons.person_rounded,
                                "Profesor",
                                Colors.green,
                                "Usa: prof",
                              ),
                              _buildInfoItem(
                                Icons.help_rounded,
                                "Demo",
                                Colors.orange,
                                "Cualquier texto",
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Solo ingresa tu tipo de usuario (sin contraseña)",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, String formType, IconData icon) {
    final isSelected = selectedForm == formType;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.principal : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () => _selectForm(formType),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : Colors.grey[600],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.people_alt_rounded, color: Colors.grey, size: 64),
            SizedBox(height: 16),
            Text(
              "Bienvenido a la Comunidad ITD",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Selecciona una opción para continuar",
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    final isLogin = selectedForm == "login";

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Campo de usuario simplificado
          _buildUserField(
            label: isLogin ? "Tipo de usuario" : "Usuario demo",
            icon: Icons.person_rounded,
            hintText: isLogin ? "Ej: est, prof, admin" : "Cualquier texto",
          ),

          const SizedBox(height: 24),

          // Botón de acción
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.principal,
                  AppColors.principal.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: AppColors.principal.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: _handleLogin,
                child: Center(
                  child: Text(
                    isLogin ? "Ingresar" : "Iniciar Demo",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Información de uso
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue[100]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info_rounded, color: Colors.blue[600], size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isLogin
                        ? "Usa 'est' para Estudiante o 'prof' para Profesor"
                        : "Cualquier texto te llevará al panel de demo",
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    IconData icon,
    String text,
    Color color,
    String subtitle,
  ) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 8, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUserField({
    required String label,
    required IconData icon,
    required String hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        controller: _userController,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600]),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500),
        onSubmitted: (value) => _handleLogin(),
      ),
    );
  }
}
