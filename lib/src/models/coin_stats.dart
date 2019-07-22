class CoinStats {
  num _price;
  num _changeDay;
  num _openDay;
  num _highDay;
  num _lowDay;

  num get price => _price;
  num get changeDay => _changeDay;
  num get openDay => _openDay;
  num get highDay => _highDay;
  num get lowDay => _lowDay;

  CoinStats._({num price, num changeDay, num openDay, num highDay, num lowDay})
      : _price = price,
        _changeDay = changeDay,
        _openDay = openDay,
        _highDay = highDay,
        _lowDay = lowDay;

  factory CoinStats.fromJson(Map<String, dynamic> json) {
    return CoinStats._(
      price: json["PRICE"],
      changeDay: json["CHANGEDAY"],
      openDay: json["OPENDAY"],
      highDay: json["HIGHDAY"],
      lowDay: json["LOWDAY"],
    );
  }
}
