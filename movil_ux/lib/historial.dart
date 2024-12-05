import 'package:flutter/material.dart';

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
      home: const HistorialComprasScreen(),
    );
  }
}

class HistorialComprasScreen extends StatelessWidget {
  const HistorialComprasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F2F89),
        title: const Text('👤 Usuario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Acción para ir al carrito
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Acción para regresar
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
                // Acción para Inicio
              },
            ),
            ListTile(
              title: const Text('Moda'),
              onTap: () {
                // Acción para Moda
              },
            ),
            ListTile(
              title: const Text('Hogar'),
              onTap: () {
                // Acción para Hogar
              },
            ),
            ListTile(
              title: const Text('Electrónica'),
              onTap: () {
                // Acción para Electrónica
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
