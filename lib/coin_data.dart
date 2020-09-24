import 'dart:convert';
import 'package:http/http.dart' as http;

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
const apiURL = 'https://rest.coinapi.io/v1/exchangerate/';
const apiKey = 'B63B4941-B4E3-4923-98D5-BCADF8BB458C';

class CoinData {
  Future getDataFromJSON(String currency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL = '$apiURL$crypto/$currency?apiKey=$apiKey';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        var price = decodedData['rate'];
        print(decodedData['rate']);
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with get request';
      }
    }
    return cryptoPrices;
  }
}
