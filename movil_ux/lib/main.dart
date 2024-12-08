import 'package:flutter/material.dart';
import 'sesion.dart'; 

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
        '/sesion': (context) => const LoginScreen(), 
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> products = [
    {
      "name": "Chamarra Greenlander",
      "image": 'assets/images/Chamarra.png',
      "price": "\$750",
      "description":
          "Esta chamarra especial Greenlander es perfecta para climas extremos. Es impermeable y duradera, ideal para aventuras al aire libre.",
      "rating": 4.5,
    },
    {
      "name": "Botas Impermeables",
      "image": 'assets/images/Botas.jpg',
      "price": "\$1200",
      "description":
          "Botas resistentes al agua, perfectas para terrenos difíciles y climas lluviosos.",
      "rating": 4.7,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2F2F89),
        title: const Text(
          'Categorías',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sesion'); 
            },
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.grey),
            onPressed: () {
              _showLoginDialog(context); 
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); 
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
              title: Text('Inicio', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: Text('Moda', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: Text('Hogar', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: Text('Electrónica', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    name: products[index]["name"] as String,
                    image: products[index]["image"] as String,
                    price: products[index]["price"] as String,
                    description: products[index]["description"] as String,
                    rating: products[index]["rating"] as double,
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      products[index]["image"] as String,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    products[index]["name"] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    products[index]["price"] as String,
                    style: const TextStyle(color: Colors.green),
                  ),
                  Text('⭐⭐⭐⭐⭐ (${products[index]["rating"]})'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Desea iniciar sesión para continuar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sesion'); 
              },
              child: const Text('Iniciar sesión'),
            ),
          ],
        );
      },
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final String description;
  final double rating;

  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2F2F89),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                price,
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text('$rating'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
