class CoinInfo {
  String _id;
  String _fullName;
  String _symbol;
  String _imageUrl;
  num _blockNumber;

  String get id => _id;
  String get fullName => _fullName;
  String get symbol => _symbol;
  String get imageUrl => _imageUrl;
  num get blockNumber => _blockNumber;

  CoinInfo._(
      {String id,
      String fullName,
      String symbol,
      String imageUrl,
      num blockNumber})
      : _id = id,
        _fullName = fullName,
        _symbol = symbol,
        _imageUrl = imageUrl,
        _blockNumber = blockNumber;

  factory CoinInfo.fromJson(Map<String, dynamic> json) {
    return CoinInfo._(
      id: json["Id"],
      fullName: json["FullName"],
      symbol: json["Name"],
      imageUrl: "https://www.cryptocompare.com" + json["ImageUrl"],
      blockNumber: json["BlockNumber"],
    );
  }
}
