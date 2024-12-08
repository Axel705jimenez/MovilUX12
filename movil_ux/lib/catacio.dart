import 'package:flutter/material.dart';
import 'carrito.dart'; 
import 'sesion.dart'; 
import 'menu.dart'; 

class CatacioScreen extends StatefulWidget {
  const CatacioScreen({super.key});

  @override
  CatacioScreenState createState() => CatacioScreenState();
}

class CatacioScreenState extends State<CatacioScreen> {
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

  final List<Map<String, dynamic>> carrito = []; 

  void agregarAlCarrito(Map<String, dynamic> producto) {
    setState(() {
      carrito.add(producto);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${producto['name']} agregado al carrito")),
    );
  }

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
            icon: const Icon(Icons.shopping_cart, color: Colors.grey),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CarritoScreen(carrito: carrito),
                ),
              );
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
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF696969)),
              child: Text(
                'Categorías',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Inicio', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context); 
              },
            ),
            ListTile(
              title: const Text('Moda', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context); 
              },
            ),
            ListTile(
              title: const Text('Hogar', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context); 
              },
            ),
            ListTile(
              title: const Text('Electrónica', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
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
                    onAddToCart: (producto) {
                      agregarAlCarrito(producto);
                    },
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
}

class ProductDetailScreen extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final String description;
  final double rating;
  final Function(Map<String, dynamic>) onAddToCart;

  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.rating,
    required this.onAddToCart,
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
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  int? cantidadSeleccionada = await _mostrarDialogoCantidad(context);
                  if (cantidadSeleccionada != null && cantidadSeleccionada > 0) {
                    Map<String, dynamic> producto = {
                      'name': name,
                      'image': image,
                      'price': price,
                      'description': description,
                      'rating': rating,
                      'quantity': cantidadSeleccionada, 
                    };
                    onAddToCart(producto); 
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F2F89),
                ),
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                label: const Text("Agregar al carrito", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<int?> _mostrarDialogoCantidad(BuildContext context) {
  int cantidad = 1; 
  return showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Selecciona la cantidad"),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Cantidad ',
                      style: TextStyle(fontSize: 24),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (cantidad > 1) {
                            cantidad--;
                          }
                        });
                      },
                    ),
                    Text(
                      '$cantidad',
                      style: const TextStyle(fontSize: 24),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          cantidad++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop(); 
            },
          ),
          TextButton(
            child: const Text('Agregar'),
            onPressed: () {
              Navigator.of(context).pop(cantidad); 
            },
          ),
        ],
      );
    },
  );
}
}