import 'package:flutter/material.dart';

import '../api/apiof_currency_rate.dart';
import 'forex_db.dart';
import '../model/forex_model.dart';

class CurrencyRateProvider extends ChangeNotifier {
  List<Country> rates = [];

  Future<void> fetchRates() async {
    await ApiOfCurrencyRate().fetchRates().then((value) async {
      await SqlHelper.deleteAll();
      await saveToDb(value);
    });

    notifyListeners();
  }

  getDataFromDatabase() async {
    rates = await SqlHelper.getItems();
    notifyListeners();
  }

  Future<void> saveToDb(List<Country> value) async {
    SqlHelper.createItem("NP", "NEPAL", "100", "100", "100");
    for (var id = 0; id < value.length; id++) {
      String buy = value[id].buy;
      String sell = value[id].sell;
      String name = value[id].name;
      String unit = value[id].unit.toString();
      String iso3 = value[id].iso3;
      await SqlHelper.createItem(iso3, name, sell, unit, buy);
    }

    await getDataFromDatabase();
  }
}
