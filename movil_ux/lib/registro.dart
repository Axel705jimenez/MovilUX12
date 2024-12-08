import 'package:flutter/material.dart';
import 'sesion.dart'; // Importa la pantalla de login si es necesario

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const RegistroUsuario(),
      theme: ThemeData(
        primaryColor: const Color(0xFF007bff),
      ),
    );
  }
}

class RegistroUsuario extends StatefulWidget {
  const RegistroUsuario({super.key});

  @override
  RegistroUsuarioState createState() => RegistroUsuarioState();
}

class RegistroUsuarioState extends State<RegistroUsuario> {
  final _formKey = GlobalKey<FormState>();
  bool _showConfirmationMessage = false;

  // Método para manejar la navegación
  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()), // Asegúrate de importar LoginScreen si no lo has hecho
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fondo.png"), // Asegúrate de registrar este archivo en pubspec.yaml
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEAEAEA),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Registro de usuario",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Usuario",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese su usuario';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Correo electrónico",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese su correo';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Contraseña",
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese su contraseña';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Adjuntar comprobante de domicilio (PDF)",
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para seleccionar un archivo PDF
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                      ),
                      child: const Text(
                        "Seleccionar archivo",
                        style: TextStyle(color: Colors.black), // Letras negras
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Adjuntar identificación (PDF)",
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para seleccionar un archivo PDF
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                      ),
                      child: const Text(
                        "Seleccionar archivo",
                        style: TextStyle(color: Colors.black), // Letras negras
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          setState(() {
                            _showConfirmationMessage = true;
                          });
                          Future.delayed(const Duration(seconds: 3), () {
                            _navigateToLogin(); // Redirige a la pantalla de login
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5797FF),
                      ),
                      child: const Text(
                        "REGISTRAR",
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                    ),
                    if (_showConfirmationMessage)
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Se enviará un correo de confirmación. Redirigiendo a la página principal...",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    const SizedBox(height: 10),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Lógica para ir a la página de inicio de sesión
                          _navigateToLogin();
                        },
                        child: const Text("¿Ya tienes cuenta? Iniciar sesión"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
