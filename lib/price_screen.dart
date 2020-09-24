

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

const String apiKey = 'B63B4941-B4E3-4923-98D5-BCADF8BB458C';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  int pricei;
  String selectedCurrency = 'INR';

  @override
  void initState() {
    super.initState();
        getData();
  }

  Map<String, String> coinVal = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;

    var data = await coinData.getDataFromJSON(selectedCurrency);
    isWaiting = false;
    setState(() {
      coinVal = data;
    });
  }

  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem<String>(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
      //coinData.getDataFromJSON();
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  Widget getPicker() {
    return Platform.isAndroid ? androidDropDownButton() : iOSPicker();
  }

  @override
  Widget build(BuildContext context) {
    print(coinVal);
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoWidget(
                cryptoTag: 'BTC',
                pricei: isWaiting ? '?' :coinVal['BTC'],
                selectedCurrency: selectedCurrency,
              ),
              CryptoWidget(
                cryptoTag: 'ETH',
                pricei: isWaiting ? '?' :coinVal['ETH'],
                selectedCurrency: selectedCurrency,
              ),
              CryptoWidget(
                cryptoTag: 'LTC',
                pricei:isWaiting ? '?' : coinVal['LTC'],
                selectedCurrency: selectedCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}

class CryptoWidget extends StatelessWidget {
  CryptoWidget({this.pricei, this.cryptoTag, this.selectedCurrency});
  final String pricei;
  final String selectedCurrency;
  final String cryptoTag;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoTag = $pricei $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
