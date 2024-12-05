import 'package:flutter/material.dart';

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


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Página principal",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
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
  void _navigateToHome() {
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fondo.png"),
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
                      child: const Text("Seleccionar archivo"),
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
                      child: const Text("Seleccionar archivo"),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          setState(() {
                            _showConfirmationMessage = true;
                          });
                          Future.delayed(const Duration(seconds: 3), () {
                            _navigateToHome(); // Navegación a través del método
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5797FF),
                      ),
                      child: const Text("REGISTRAR"),
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
