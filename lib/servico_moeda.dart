import 'dart:convert';
import 'package:http/http.dart' as http;

class ServicoMoeda {
  Future<double> converterMoeda(String moedaOrigem, String moedaDestino) async {
    final chaveAPI = 'fca_live_rSRbTLBovjW0nvhKUbjaK7omihlOdUx08IEZulU9';
    final resposta = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/$moedaOrigem?access_key=$chaveAPI'));

    if (resposta.statusCode == 200) {
      var jsonResponse = jsonDecode(resposta.body);
      double taxaCambio = jsonResponse['rates'][moedaDestino];
      return taxaCambio;
    } else {
      throw Exception('Falha ao carregar a taxa de câmbio');
    }
  }
}
