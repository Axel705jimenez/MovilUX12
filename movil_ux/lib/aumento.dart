import 'package:flutter/material.dart';
import 'package:movil_ux/sesion.dart'; 
import 'carrito.dart';
import 'menu.dart'; // Asegúrate de importar MenuScreen

class AumentoScreen extends StatelessWidget {
  const AumentoScreen({super.key});

  void _mostrarConfirmacionCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Estás seguro?'),
          content: const Text('¿Deseas cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo sin hacer nada
              },
            ),
            TextButton(
              child: const Text('Sí'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()), // Redirigir a Sesion.dart
                );
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // Controladores de los campos de texto
    final montoController = TextEditingController();
    final ingresoController = TextEditingController();
    final motivoController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F2F89),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ícono de regreso
          onPressed: () {
            Navigator.pop(context); // Regresar a la pantalla anterior
          },
        ),
        actions: [
          // PopupMenuButton para el menú del usuario
          PopupMenuButton<String>(
            icon: const Icon(Icons.person, color: Colors.white),
            onSelected: (String value) {
              if (value == 'miCuenta') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                );
              } else if (value == 'cerrarSesion') {
                _mostrarConfirmacionCerrarSesion(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'miCuenta',
                  child: Text('Mi cuenta'),
                ),
                const PopupMenuItem<String>(
                  value: 'cerrarSesion',
                  child: Text('Cerrar sesión'),
                ),
              ];
            },
            offset: const Offset(100, 50),
          ),
          // Ícono del carrito de compras
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              // Acción del carrito
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CarritoScreen(carrito: [])),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF2F2F89),
              ),
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Inicio'),
              onTap: () {
                // Navegación a Inicio
              },
            ),
            ListTile(
              title: const Text('Moda'),
              onTap: () {
                // Navegación a Moda
              },
            ),
            ListTile(
              title: const Text('Hogar'),
              onTap: () {
                // Navegación a Hogar
              },
            ),
            ListTile(
              title: const Text('Electrónica'),
              onTap: () {
                // Navegación a Electrónica
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Images/Background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Solicitud de Aumento de Crédito",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: montoController,
                      decoration: const InputDecoration(
                        labelText: "Monto Deseado",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: ingresoController,
                      decoration: const InputDecoration(
                        labelText: "Ingreso Mensual",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: motivoController,
                      decoration: const InputDecoration(
                        labelText: "Describa el motivo",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Validar si los campos están vacíos
                        if (montoController.text.isEmpty || ingresoController.text.isEmpty || motivoController.text.isEmpty) {
                          // Mostrar mensaje de error si algún campo está vacío
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Por favor, complete todos los campos'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          // Mostrar mensaje de éxito si todos los campos están completos
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Se ha enviado la solicitud, se le enviará un correo de aceptación'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  const Color(0xFF2F2F89),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        "Solicitar",
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
