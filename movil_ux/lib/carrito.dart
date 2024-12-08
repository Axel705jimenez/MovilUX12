import 'package:flutter/material.dart';
import 'package:movil_ux/catacio.dart';
import 'package:movil_ux/menu.dart';
import 'package:movil_ux/sesion.dart';
import 'package:movil_ux/tarjeta.dart';

class CarritoScreen extends StatefulWidget {
  final List<Map<String, dynamic>> carrito; 
  const CarritoScreen({super.key, required this.carrito});

  @override
  CarritoScreenState createState() => CarritoScreenState();
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
class CarritoScreenState extends State<CarritoScreen> {
  double _calcularTotal() {
    double total = 0.0;
    for (var producto in widget.carrito) {
      double precio =
          double.tryParse(producto['price'].replaceAll(RegExp(r'[^\d.]'), '')) ??
              0.0; 
      int cantidad = producto['quantity'] ?? 1;
      total += precio * cantidad;
    }
    return total;
  }

  void _eliminarProducto(int index) {
    setState(() {
      widget.carrito.removeAt(index); 
    });
  }

  void _mostrarMetodoDePago() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Text(
        "Selecciona un método de pago",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(Icons.credit_card, color: Colors.blue),
              title: const Text("Pagar con tarjeta", style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.of(context).pop(); 
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PagoConTarjetaScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(Icons.store, color: Colors.green),
              title: const Text("Usar crédito de la tienda", style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.of(context).pop(); 
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pago realizado con crédito de la tienda")),
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const CatacioScreen()),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(Icons.account_balance, color: Colors.orange),
              title: const Text("Pago por SPEI", style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.of(context).pop(); 
                _mostrarDetallesSpei(context);
              },
            ),
          ),
        ],
      ),
    ),
  );
}

void _mostrarDetallesSpei(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Text(
        "Detalles para SPEI",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Banco: STP", style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text("Cuenta: 1234 5678 9101 1121", style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text("CLABE: 012345678901234567", style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text("Titular: Axel Guadalupe Jimenez Maltos", style: TextStyle(fontSize: 16)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); 
          },
          child: const Text("Cerrar"),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    const double envio = 150.0; 

    return Scaffold(
    appBar: AppBar(
  title: const Text("Carrito"),
  backgroundColor: const Color(0xFF2F2F89),
  iconTheme: const IconThemeData(color: Colors.white),
  titleTextStyle: const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: PopupMenuButton<String>(
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
    ),
  ],
),


      body: widget.carrito.isEmpty
          ? const Center(child: Text("Tu carrito está vacío"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: widget.carrito.length,
                    itemBuilder: (context, index) {
                      var producto = widget.carrito[index];
                      int cantidad = producto['quantity'] ?? 1;
                      return Card(
                        elevation: 4,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: Image.asset(
                                  producto['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      producto['name'],
                                      style: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      producto['price'],
                                      style: const TextStyle(
                                          color: Colors.green, fontSize: 16),
                                    ),
                                    const SizedBox(height: 8),
                                    TextButton(
                                      onPressed: () {
                                        _eliminarProducto(index);
                                      },
                                      child: const Text(
                                        'Eliminar',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Cantidad ',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {
                                            setState(() {
                                              if (cantidad > 1) {
                                                producto['quantity'] = cantidad - 1;
                                              }
                                            });
                                          },
                                        ),
                                        Text(
                                          '$cantidad',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              producto['quantity'] = cantidad + 1;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Envío:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${envio.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${(_calcularTotal() + envio).toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _mostrarMetodoDePago,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F2F89),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Realizar Pago',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
