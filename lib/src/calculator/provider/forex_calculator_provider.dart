import 'package:flutter/material.dart';
import 'package:hh/src/calculator/dbhelper/sql_history.dart';

import '../../forex/dbhelper/forex_db.dart';
import '../../forex/model/forex_model.dart';

class ForexCalculatorState extends ChangeNotifier {
  Country selectedCountry1 = Country.fromJson({});
  Country selectedCountry2 = Country.fromJson({});

  List<Country> countryList = [];
  Future<void> getCountryList() async {
    countryList = await SqlHelper.getItems();
    selectedCountry1 =
        countryList.isNotEmpty ? countryList[0] : Country.fromJson({});
    selectedCountry2 =
        countryList.isNotEmpty ? countryList[0] : Country.fromJson({});

    notifyListeners();
  }

  double calculation() {
    double converted = 0.0;

    try {
      double fromCurrencySell = double.parse(selectedCountry1.sell);
      double toCurrencyBuy = double.parse(selectedCountry2.buy);
      double toCurrencyUnit = double.parse(selectedCountry2.unit);
      double fromCurrencyUnit = double.parse(selectedCountry1.unit);

      if (fromCurrencyUnit != 0 && fromCurrencySell != 0) {
        converted = (toCurrencyBuy /
            fromCurrencyUnit *
            toCurrencyUnit /
            fromCurrencySell);
      } else {
        converted = 0.0;
      }
    } catch (e) {
      //print('Error parsing double: $e');
      // Handle the error, provide default values, or show an error message
      // Provide a default value when parsing fails
      converted = 0.0;
    }

    return converted;
  }

//
  // calculation() {
  //   double converted = 0.0;
  //   double fromCurrencySell = double.parse(selectedCountry1.sell);
  //   double toCurrencyBuy = double.parse(selectedCountry2.buy);
  //
  //   double toCurrencyUnit = double.parse(selectedCountry2.unit);
  //   double fromCurrencyUnit = double.parse(selectedCountry1.unit);
  //
  //   return converted =
  //       (toCurrencyBuy / fromCurrencyUnit * toCurrencyUnit / fromCurrencySell);
  // }
}
