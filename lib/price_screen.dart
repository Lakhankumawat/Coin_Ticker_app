import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> l = [];
    for (String current in currenciesList) {
      l.add(
        DropdownMenuItem(
          child: Text(current),
          value: current,
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: l,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value as String;
          //2: Call getData() when the picker/dropdown changes.
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String current in currenciesList) {
      pickerItems.add(Text(current));
    }
    return CupertinoPicker(
      backgroundColor: Color(0x45b134bb),
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        setState(() {
          //1: Save the selected currency to the property selectedCurrency
          selectedCurrency = currenciesList[selectedIndex];
          //2: Call getData() when the picker/dropdown changes.
          getData();
        });
      },
      children: pickerItems,
    );
  }

  String bitcoinValue = '?';
  String ethereumValue = '?';
  String litecoinValue = '?';
  CoinData coin = CoinData();
  bool isWaitingtoFetch = false;
  Map<String, String> coinValues = {};
  // ignore: non_constant_identifier_names
  void getData() async {
    try {
      isWaitingtoFetch = true;
      //We're now passing the selectedCurrency when we call getCoinData().

      var data = await CoinData().getCoinData(selectedCurrency);
      isWaitingtoFetch = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Coin Ticker'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CryptoCard(
            'BTC',
            isWaitingtoFetch ? '?' : coinValues['BTC'] as String,
            selectedCurrency,
          ),
          CryptoCard(
            'ETH',
            isWaitingtoFetch ? '?' : coinValues['ETH'] as String,
            selectedCurrency,
          ),
          CryptoCard(
            'LTC',
            isWaitingtoFetch ? '?' : coinValues['LTC'] as String,
            selectedCurrency,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0x45b134bb),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Scroll Down : '),
                Platform.isIOS ? iOSPicker() : androidDropDown(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Expanded CryptoCard(String text, String value, String selectedCurrency) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 18.0, 18.0, 20.0),
        child: Card(
          color: Color(0xFF8c0a92),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Center(
              child: Text(
                '1 $text = $value $selectedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
