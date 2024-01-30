import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/forex_model.dart';

class ApiofCurrencyRate {
  final String apiUrl = 'https://www.nrb.org.np/api/forex/v1/app-rate';

  Future<List<Country>> fetchRates() async {
    final uri = Uri.parse(apiUrl);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      return (json as List<dynamic>)
          .map((userJson) => Country.fromJson(userJson))
          .toList();
    } else {
      return [];
    }
  }
}
