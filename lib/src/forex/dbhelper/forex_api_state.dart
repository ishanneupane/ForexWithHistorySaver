import 'package:flutter/material.dart';

import '../api/apiof_currency_rate.dart';
import 'forex_db.dart';
import '../model/forex_model.dart';

class CurrencyRateProvider extends ChangeNotifier {
  List<Country> rates = [];

  Future<void> fetchRates() async {
    await ApiofCurrencyRate().fetchRates().then((value) async {
      await Sqlhelper.deleteAll();
      await saveToDb(value);
    });

    notifyListeners();
  }

  getDataFromDatabase() async {
    rates = await Sqlhelper.getItems();
    notifyListeners();
  }

  Future<void> saveToDb(List<Country> value) async {
    for (var id = 0; id < value.length; id++) {
      String buy = value[id].buy;
      String sell = value[id].sell;
      String name = value[id].name;
      String unit = value[id].unit.toString();
      String iso3 = value[id].iso3;

      await Sqlhelper.createItem(iso3, name, sell, unit, buy);
    }

    await getDataFromDatabase();
  }
}
