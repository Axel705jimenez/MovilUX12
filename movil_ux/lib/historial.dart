import 'package:flutter/material.dart';
import 'package:movil_ux/sesion.dart';
import 'carrito.dart'; 
import 'menu.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color(0xFF2F2F89)),
      home: const HistorialScreen(),
    );
  }
}

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

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
        actions: [
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
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Redirigir al carrito
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CarritoScreen(carrito: [])),
              );
            },
          ),
        ],
              leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

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
              },
            ),
            ListTile(
              title: const Text('Moda'),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('Hogar'),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('Electrónica'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Historial de compras',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                buildPurchaseItem('Smartphone XYZ', 1, '2024-11-01', 150.0),
                buildPurchaseItem('Producto: Smartphone XYZ', 1, '2024-11-01', 150.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPurchaseItem(String title, int quantity, String date, double price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Cantidad: $quantity'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fecha de compra: $date'),
                Text('\$$price', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}