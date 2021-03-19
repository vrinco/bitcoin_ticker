import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String kUrl = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

class CoinData {
  Map<String, double> cryptoValues = {};

  Future getData(String currency) async {
    var random = new Random();
    for (String curr in cryptoList) {
      http.Response response = await http.get('${kUrl}BTC$currency');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        cryptoValues[curr] = data['last'];
      } else {
        print('Htpp error $response.statusCode');
        cryptoValues[curr] = random.nextInt(1000) * random.nextDouble();
      }
    }
  }

  String getCryptoValue(String crypto) {
    if (cryptoValues.containsKey(crypto))
      return cryptoValues[crypto].toStringAsFixed(2);
    else
      return "?";
  }
}
