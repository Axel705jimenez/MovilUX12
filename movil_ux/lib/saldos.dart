import 'package:flutter/material.dart';
import 'package:movil_ux/carrito.dart';
import 'package:movil_ux/menu.dart';
import 'package:movil_ux/sesion.dart';
import 'package:movil_ux/tarjeta.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SaldosScreen(),
    );
  }
}

class SaldosScreen extends StatelessWidget {
  const SaldosScreen({super.key});

  void _mostrarMetodoDePago(BuildContext context) {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PagoConTarjetaScreen()),
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
            Text("Banco: BBVA Bancomer", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Cuenta: 1234 5678 9101 1121", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("CLABE: 012345678901234567", style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text("Titular: Empresa XYZ", style: TextStyle(fontSize: 16)),
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
        title: const Text(
          'Detalles',
          style: TextStyle(color: Colors.white),
        ),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CarritoScreen(carrito: [])),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Detalles', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),

                    Card(
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
                    SizedBox(height: 20),

                    Text('Saldos', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pagos vencidos', style: TextStyle(fontSize: 16)),
                        Text('\$500', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Próximo pago', style: TextStyle(fontSize: 16)),
                        Text('\$200', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Deuda total actual', style: TextStyle(fontSize: 16)),
                        Text('\$700', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Fecha de corte', style: TextStyle(fontSize: 16)),
                        Text('15 de noviembre, 2024', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Fecha límite de pago', style: TextStyle(fontSize: 16)),
                        Text('30 de noviembre, 2024', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () => _mostrarMetodoDePago(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F2F89),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Text(
                  'Realizar pago',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
