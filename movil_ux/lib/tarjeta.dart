import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'catacio.dart';

class PagoConTarjetaScreen extends StatelessWidget {
  const PagoConTarjetaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nombreTitularController = TextEditingController();
    final TextEditingController numeroTarjetaController = TextEditingController();
    final TextEditingController mesExpiracionController = TextEditingController();
    final TextEditingController anioExpiracionController = TextEditingController();
    final TextEditingController cvvController = TextEditingController();
    final TextEditingController direccionFacturacionController = TextEditingController();
    final TextEditingController codigoPostalController = TextEditingController();

    return Scaffold(
     appBar: AppBar(
  title: const Text(
    "Pago con Tarjeta",
    style: TextStyle(color: Colors.white), 
  ),
  backgroundColor: const Color(0xFF2F2F89), 
  iconTheme: const IconThemeData(color: Colors.white), 
),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Introduce los datos de tu tarjeta",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nombreTitularController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: "Nombre del titular",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: numeroTarjetaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Número de tarjeta",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: mesExpiracionController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Mes (MM)",
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: anioExpiracionController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Año (AA)",
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cvvController,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "CVV (Código de seguridad)",
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, 
                LengthLimitingTextInputFormatter(3),     
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: direccionFacturacionController,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                labelText: "Dirección de facturación (opcional)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: codigoPostalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Código postal (opcional)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (nombreTitularController.text.isEmpty ||
                      numeroTarjetaController.text.isEmpty ||
                      mesExpiracionController.text.isEmpty ||
                      anioExpiracionController.text.isEmpty ||
                      cvvController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Por favor, completa todos los campos obligatorios."),
                      ),
                    );
                  } else if (int.tryParse(mesExpiracionController.text) == null ||
                      int.tryParse(anioExpiracionController.text) == null ||
                      int.parse(mesExpiracionController.text) < 1 ||
                      int.parse(mesExpiracionController.text) > 12) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Introduce un mes válido (1-12)."),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Pago procesado con éxito")),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const CatacioScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F2F89),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Realizar Pago",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
