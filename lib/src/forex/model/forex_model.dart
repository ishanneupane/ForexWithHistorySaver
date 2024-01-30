class Country {
  String iso3;
  String name;
  String unit;
  String buy;
  String sell;
  // DateTime date;
  // DateTime publishedOn;
  // DateTime modifiedOn;

  Country({
    required this.iso3,
    required this.name,
    required this.unit,
    required this.buy,
    required this.sell,
    // required this.date,
    // required this.publishedOn,
    // required this.modifiedOn,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      iso3: json['iso3'] ?? "",
      name: json['name'] ?? "",
      unit: json['unit'] == null ? "" : json['unit'].toString(),
      buy: json['buy'] ?? "",
      sell: json['sell'] ?? "",
      // date: DateTime.parse(json['date']),
      // publishedOn: DateTime.parse(json['publishedOn']),
      // modifiedOn: DateTime.parse(json['modifiedOn']),
    );
  }
}
