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

//TODO: this API Key won't work in your case head over to CoinApi.io and generate your own API Key Copy Paste Here and that's all you need to do , Happy Coding !!
const APIKEY = '1B73D67E-FFFFFFFFFFF-A2874C019C21';
const coinAPI = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<dynamic> getCoinData(String selectedCurrency) async {
    Map<String, String> cryptomap = {};
    for (String crypto in cryptoList) {
      var uri = Uri.parse('$coinAPI/$crypto/$selectedCurrency?apikey=$APIKEY');
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
