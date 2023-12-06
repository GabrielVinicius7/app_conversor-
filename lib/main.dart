import 'package:flutter/material.dart';
import 'servico_moeda.dart';
import 'conversor_moeda.dart';

void main() {
  runApp(AppConversorMoeda());
}

class AppConversorMoeda extends StatelessWidget {
  final ServicoMoeda servicoMoeda = ServicoMoeda();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: GlobalKey<ScaffoldState>(),
        appBar: AppBar(
          title: Text('Conversor de Moeda'),
          backgroundColor: const Color.fromARGB(255, 8, 8, 8),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Image.network(
              'https://media.tenor.com/hg5MQw7pJVcAAAAC/cash-fortress-snipers-eye.gif',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Center(
              child: Container(
                height: 500.0,
                width: 300.0,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 185, 182, 182).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
                child: ConversorDeMoeda(servicoMoeda: servicoMoeda),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
