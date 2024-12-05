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
      theme: ThemeData(primaryColor: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👤 Usuario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/carrito');
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
      body: Container(
        decoration: const BoxDecoration(

        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detalles de la cuenta',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Card(
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
               Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Expanded(
      child: IconButton(
        icon: Image.asset('assets/images/btnHistorial.png'),
        iconSize: 100,
        onPressed: () {
          Navigator.pushNamed(context, '/HistorialCompras');
        },
      ),
    ),
    Expanded(
      child: IconButton(
        icon: Image.asset('assets/images/btnaumento.png'),
        iconSize: 100,
        onPressed: () {
          Navigator.pushNamed(context, '/aumento');
        },
      ),
    ),
  ],
)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
