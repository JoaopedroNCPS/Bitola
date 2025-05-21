import 'package:flutter/material.dart';

void main() {
  runApp(SimuladorBitolaApp());
}

class SimuladorBitolaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo de Bitola',
      home: CalculadoraBitola(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculadoraBitola extends StatefulWidget {
  @override
  _CalculadoraBitolaState createState() => _CalculadoraBitolaState();
}

class _CalculadoraBitolaState extends State<CalculadoraBitola> {
  final TextEditingController _correnteController = TextEditingController();
  final TextEditingController _distanciaController = TextEditingController();

  double _bitola110 = 0;
  double _bitola220 = 0;

  void _calcularBitola() {
    double corrente = double.tryParse(_correnteController.text) ?? 0;
    double distancia = double.tryParse(_distanciaController.text) ?? 0;

    setState(() {
      _bitola110 = (2 * corrente * distancia) / 294.64;
      _bitola220 = (2 * corrente * distancia) / 510.4;
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Resultado'),
        content: Text(
          'Bitola para 110V: ${_bitola110.toStringAsFixed(2)} mm²\n'
          'Bitola para 220V: ${_bitola220.toStringAsFixed(2)} mm²',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      appBar: AppBar(
        title: Text('Cálculo de Bitola de Fio'),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            Text('Corrente elétrica (A):'),
            TextField(
              controller: _correnteController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Ex: 15',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('Distância (m):'),
            TextField(
              controller: _distanciaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Ex: 30',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calcularBitola,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: Text('Calcular'),
            ),
            SizedBox(height: 30),
            Text(
              'Bitola para 110V: ${_bitola110.toStringAsFixed(2)} mm²',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Bitola para 220V: ${_bitola220.toStringAsFixed(2)} mm²',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
