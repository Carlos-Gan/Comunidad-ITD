import 'package:flutter/material.dart';
import '../extras/AppColors.dart';
import 'panel_principal.dart';

class PanelInicio extends StatefulWidget {
  const PanelInicio({super.key});

  @override
  State<PanelInicio> createState() => _PanelInicioState();
}

class _PanelInicioState extends State<PanelInicio> with SingleTickerProviderStateMixin {
  String? selectedForm;
  bool _obscure = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectForm(String formType) {
    setState(() {
      selectedForm = formType;
    });
    _animationController.forward(from: 0.0);
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
                          "Conecta con tu comunidad estudiantil",
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
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
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
                                    "Registrarse",
                                    "register",
                                    Icons.app_registration_rounded,
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
                            child: selectedForm == null
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
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
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
                              _buildInfoItem(Icons.security_rounded, "Seguro", Colors.green),
                              _buildInfoItem(Icons.people_rounded, "Comunidad", Colors.blue),
                              _buildInfoItem(Icons.school_rounded, "Educación", Colors.orange),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Plataforma oficial del Instituto Tecnológico de Durango",
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.people_alt_rounded,
            color: Colors.grey,
            size: 64,
          ),
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
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
          // Campos del formulario
          _buildTextField(
            label: isLogin ? "Usuario" : "Nombre completo",
            icon: isLogin ? Icons.person_rounded : Icons.badge_rounded,
          ),
          
          const SizedBox(height: 16),
          
          if (!isLogin) ...[
            _buildTextField(
              label: "Usuario",
              icon: Icons.person_outline_rounded,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: "Número de control",
              icon: Icons.numbers_rounded,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: "Correo electrónico",
              icon: Icons.email_rounded,
            ),
            const SizedBox(height: 16),
          ],
          
          _buildPasswordField(),
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
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const PanelPrincipal(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    isLogin ? "Iniciar Sesión" : "Crear Cuenta",
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
          
          // Enlace adicional
          if (isLogin) ...[
            TextButton(
              onPressed: () {
                // Lógica para recuperar contraseña
              },
              child: Text(
                "¿Olvidaste tu contraseña?",
                style: TextStyle(
                  color: AppColors.principal,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ] else ...[
            Text(
              "Al registrarte aceptas nuestros términos y condiciones",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text, Color color) {
    return Column(
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
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: Icon(icon, color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextFormField(
        obscureText: _obscure,
        decoration: InputDecoration(
          labelText: 'Contraseña',
          labelStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: Icon(Icons.lock_rounded, color: Colors.grey[500]),
          suffixIcon: IconButton(
            icon: Icon(
              _obscure ? Icons.visibility_rounded : Icons.visibility_off_rounded,
              color: Colors.grey[500],
            ),
            onPressed: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'La contraseña es obligatoria';
          }
          return null;
        },
      ),
    );
  }
}