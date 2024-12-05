import 'package:flutter/material.dart';
import 'sesion.dart'; // Importamos la clase LoginScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      routes: {
        '/sesion': (context) => const LoginScreen(), // Configuramos la ruta
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // Definir el ScaffoldKey para manejar el Drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Asignar el key al Scaffold
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F2F89),
        title: const Text(
          'Categorías',
          style: TextStyle(color: Colors.white), // Título en blanco
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sesion'); // Navegar a LoginScreen
            },
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.grey, // Carrito en gris claro
            ),
            onPressed: () {
              _showLoginDialog(context); // Mostrar el diálogo de inicio de sesión
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white, // Menú en blanco
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Abrir el menú lateral
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF696969),
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF696969)),
              child: Text(
                'Categorías',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text(
                'Inicio',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: Text(
                'Moda',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: Text(
                'Hogar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: Text(
                'Electrónica',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
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
              'assets/images/Chamarra.png',
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

  // Mostrar el diálogo para iniciar sesión
  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Desea iniciar sesión para continuar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sesion'); // Ir a la pantalla de inicio de sesión
              },
              child: const Text('Iniciar sesión'),
            ),
          ],
        );
      },
    );
  }
}
