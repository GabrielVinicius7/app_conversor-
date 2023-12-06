// Importando os pacotes necessários
import 'package:flutter/material.dart';
import 'servico_moeda.dart';  // Sugestão de nome para 'currency_service.dart'

// Definindo um StatefulWidget que aceita um ServicoMoeda como parâmetro
class ConversorDeMoeda extends StatefulWidget {
  final ServicoMoeda servicoMoeda;

  ConversorDeMoeda({required this.servicoMoeda});

  @override
  _ConversorDeMoedaState createState() => _ConversorDeMoedaState();
}

// Definindo o estado do StatefulWidget
class _ConversorDeMoedaState extends State<ConversorDeMoeda> {
  String moedaOrigem = 'USD'; // Moeda de origem inicial
  String moedaDestino = 'BRL'; // Moeda de destino inicial
  double valor = 1.0; // Valor inicial a ser convertido

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Campo de texto para entrada do valor a ser convertido
        TextField(
          onChanged: (texto) {
            if (texto.isNotEmpty) {
              var valorEntrada = double.tryParse(texto);
              if (valorEntrada != null) {
                setState(() {
                  valor = valorEntrada;
                });
              } else {
                // Exibe um SnackBar se o valor inserido não for um número válido
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Por favor, insira um número válido.')),
                );
              }
            } else {
              setState(() {
                valor = 1.0;
              });
            }
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Valor',
            labelStyle: TextStyle(fontSize: 18.0),
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        // Dropdown para selecionar a moeda de origem
        DropdownButton<String>(
          value: moedaOrigem,
          onChanged: (String? novaMoeda) {
            setState(() {
              moedaOrigem = novaMoeda!;
            });
          },
          items: obterItensDropdownMoedas(),
        ),
        SizedBox(height: 16.0),
        // Dropdown para selecionar a moeda de destino
        DropdownButton<String>(
          value: moedaDestino,
          onChanged: (String? novaMoeda) {
            setState(() {
              moedaDestino = novaMoeda!;
            });
          },
          items: obterItensDropdownMoedas(),
        ),
        SizedBox(height: 30.0),
        // FutureBuilder para exibir o resultado da conversão
        FutureBuilder<double>(
          future: widget.servicoMoeda.converterMoeda(moedaOrigem, moedaDestino),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                '$valor $moedaOrigem é igual a ${snapshot.data! * valor} $moedaDestino',
                style: TextStyle(fontSize: 18.0),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}", style: TextStyle(fontSize: 18.0));
            }

            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }

  // Função para gerar os itens do Dropdown
  List<DropdownMenuItem<String>> obterItensDropdownMoedas() {
    return <String>['USD - Dólar', 'BRL - Real', 'EUR - Euro', 'JPY - Iene', 'GBP - Libra', 'AUD - Dólar', 'CAD - Dólar', 'CHF - Franco', 'CNY - Yuan', 'SEK - Coroa', 'NZD - Dólar']
        .map<DropdownMenuItem<String>>((String valor) {
      return DropdownMenuItem<String>(
        value: valor.substring(0, 3),
        child: Text(valor, style: TextStyle(fontSize: 16.0)),
      );
    }).toList();
  }
}
