import 'package:flutter/material.dart';
import 'package:movil_ux/sesion.dart';
import 'catacio.dart';
import 'carrito.dart';
import 'aumento.dart';
import 'historial.dart';
import 'saldos.dart'; 

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: const Text('Sí'),
              onPressed: () {
                Navigator.of(context).pop(); 
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()), 
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F2F89),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CatacioScreen()),
            );
          },
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.person, color: Colors.white),
            onSelected: (String value) {
              if (value == 'cerrarSesion') {
                _mostrarConfirmacionCerrarSesion(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'cerrarSesion',
                  child: Text('Cerrar sesión'),
                ),
              ];
            },
            offset: const Offset(100, 50),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
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
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menú'),
            ),
            ListTile(
              title: const Text('Inicio'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Moda'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Hogar'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Electrónica'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detalles de la cuenta',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SaldosScreen()),
                  );
                },
                child: const Card(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Crédito disponible', style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text('\$1,500', style: TextStyle(fontSize: 24, color: Colors.green)),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Crédito total:', style: TextStyle(fontSize: 16)),
                            Text('\$3,000', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: IconButton(
                      icon: Image.asset('assets/images/btnHistorial.png'),
                      iconSize: 100,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HistorialScreen()),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Image.asset('assets/images/btnaumento.png'),
                      iconSize: 100,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AumentoScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
