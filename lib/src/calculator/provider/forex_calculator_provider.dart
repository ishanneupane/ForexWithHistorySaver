import 'package:flutter/material.dart';
import 'package:hh/src/calculator/dbhelper/sql_history.dart';

import '../../forex/dbhelper/forex_db.dart';
import '../../forex/model/forex_model.dart';

class ForexCalculatorState extends ChangeNotifier {
  Country selectedCountry1 = Country.fromJson({});
  Country selectedCountry2 = Country.fromJson({});

  List<Country> countryList = [];
  Future<void> getCountryList() async {
    countryList = await Sqlhelper.getItems();
    selectedCountry1 = countryList[0];
    selectedCountry2 = countryList[1];

    notifyListeners();
  }

  calculation() {
    double converted = 0.0;
    double fromCurrencySell = double.parse(selectedCountry1.sell);
    double toCurrencyBuy = double.parse(selectedCountry2.buy);

    double toCurrencyUnit = double.parse(selectedCountry2.unit);
    double fromCurrencyUnit = double.parse(selectedCountry1.unit);
    SqlHistory.createItem(
        converted, converted, selectedCountry1.name, selectedCountry2.name);
    return converted =
        (toCurrencyBuy / fromCurrencyUnit * toCurrencyUnit / fromCurrencySell);
  }
}
