import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        primaryColor: const Color(0xFF2F2F89), // Color principal
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState(); // Asegúrate de que devuelva State<HomePage>
}

class HomePageState extends State<HomePage> {
  bool _isSidebarCollapsed = true;

  void _toggleSidebar() {
    setState(() {
      _isSidebarCollapsed = !_isSidebarCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: _toggleSidebar,
            ),
            const Text("Aplicación Web"),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                // Navegar al perfil del usuario
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                // Navegar al carrito
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2F2F89),
      ),
      body: Row(
        children: [
          // Sidebar
          if (!_isSidebarCollapsed)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 200, // Ancho fijo cuando no está colapsado
              color: const Color(0xFF696969),
              padding: const EdgeInsets.only(top: 80),
              curve: Curves.easeInOut,
              child: const Column(
                children: [
                  ListTile(title: Text("Inicio")),
                  ListTile(title: Text("Moda")),
                  ListTile(title: Text("Hogar")),
                  ListTile(title: Text("Electrónica")),
                ],
              ),
            ),
          // Contenido principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView( // Hacer que el contenido sea desplazable
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Para hombre", style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 16),
                    // Productos
                    GridView.builder(
                      shrinkWrap: true, // Permitir que el GridView ocupe solo el espacio necesario
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: 10, // Cantidad de productos
                      itemBuilder: (context, index) {
                        return const ProductCard();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/Chamarra.png', fit: BoxFit.cover),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Chamarra especial\nGreenlander\nImpermeable"),
                SizedBox(height: 8),
                Text("\$750", style: TextStyle(color: Colors.green)),
                SizedBox(height: 4),
                Text("⭐⭐⭐⭐⭐ (18)"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
