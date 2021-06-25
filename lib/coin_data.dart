import 'package:http/http.dart' as http;
import 'dart:convert';

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

const APIKEY2 = 'DB21A1A4-07DA-4938-9D0B-E7DF594E23D7';
const APIKEY = '1B73D67E-5B70-4728-A5B3-A2874C019C21';
const coinAPI = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<dynamic> getCoinData(String selectedCurrency) async {
    Map<String, String> cryptomap = {};
    for (String crypto in cryptoList) {
      var uri = Uri.parse('$coinAPI/$crypto/$selectedCurrency?apikey=$APIKEY2');
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        double rate = data['rate'];
        cryptomap[crypto] = rate.toStringAsFixed(0);
      } else {
        print(response.statusCode);
      }
    }
    return cryptomap;
  }
}
