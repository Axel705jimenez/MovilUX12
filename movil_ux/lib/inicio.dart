import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación Web',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _isSidebarOpen = false;  // Esta variable controla la visibilidad del Drawer.

  // Método para alternar el estado del menú lateral.
  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F2F89),
        title: const Text('☰ Categorías'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          // IconButton para alternar el menú lateral.
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: _toggleSidebar, // Llama al método para alternar el Drawer.
          ),
        ],
      ),
      drawer: _isSidebarOpen  // Muestra el Drawer si _isSidebarOpen es verdadero.
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Color(0xFF696969)),
                    child: Text('Categorías', style: TextStyle(color: Colors.white)),
                  ),
                  ListTile(title: Text('Inicio')),
                  ListTile(title: Text('Moda')),
                  ListTile(title: Text('Hogar')),
                  ListTile(title: Text('Electrónica')),
                ],
              ),
            )
          : null, // Si _isSidebarOpen es falso, no se muestra el Drawer.
      body: Stack(
        children: [
          _buildBackground(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Ofertas de tiempo limitado',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildProductGrid(),
                  const SizedBox(height: 32),
                  const Text(
                    'Hasta 40% de descuento',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildProductGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildProductCard();
      },
    );
  }

  Widget _buildProductCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              'assets/Chamarra.png',
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Chamarra especial\nGreenlander\nImpermeable',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('\$750', style: TextStyle(color: Colors.green)),
                Text('⭐⭐⭐⭐⭐ (18)'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
