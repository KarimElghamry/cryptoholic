import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class PrivateData {
  String _apiKey;

  String get apiKey => _apiKey;

  PrivateData._(this._apiKey);

  factory PrivateData.fromJson(Map<String, dynamic> json) {
    return PrivateData._(json["apiKey"]);
  }

  static Future<PrivateData> fromAssets(String path) async {
    final String _text = await rootBundle.loadString(path);
    final Map<String, dynamic> _json = jsonDecode(_text);
    return PrivateData.fromJson(_json);
  }
}
