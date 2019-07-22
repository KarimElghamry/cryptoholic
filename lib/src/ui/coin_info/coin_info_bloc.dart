import 'dart:convert';
import 'package:cryptoholic/src/models/selected_time_mode.dart';
import 'package:http/http.dart' as http;
import 'package:cryptoholic/src/models/history.dart';
import 'package:cryptoholic/src/models/private_data.dart';
import 'package:rxdart/rxdart.dart';

class CoinInfoBloc {
  BehaviorSubject<History> _history$;
  BehaviorSubject<SelectedTimeMode> _timeMode$;
  BehaviorSubject<bool> _isLoading$;
  String _symbol;
  bool _isLoading;

  BehaviorSubject<History> get history$ => _history$;
  BehaviorSubject<SelectedTimeMode> get timeMode$ => _timeMode$;
  BehaviorSubject<bool> get isLoading$ => _isLoading$;

  CoinInfoBloc(String symbol) {
    _symbol = symbol;
    _isLoading = false;
    _history$ = BehaviorSubject<History>();
    _isLoading$ = BehaviorSubject<bool>();
    _timeMode$ =
        BehaviorSubject<SelectedTimeMode>.seeded(SelectedTimeMode.Daily);
    getDailyHistory();
  }

  Future<void> getDailyHistory() async {
    if (_isLoading) {
      return;
    }
    _isLoading = true;
    _history$.add(null);
    updateTimeMode(SelectedTimeMode.Daily);
    final PrivateData _privateData =
        await PrivateData.fromAssets("privateData.json");
    final String _url =
        "https://min-api.cryptocompare.com/data/histoday?fsym=" +
            _symbol +
            "&tsym=USD&limit=7&api_key=" +
            _privateData.apiKey;

    final _response = await http.get(_url);
    final Map<String, dynamic> _json = jsonDecode(_response.body);
    final History _history = History.fromJson(_json);
    _history$.add(_history);
    _isLoading = false;
  }

  Future<void> getHourlyHistory() async {
    if (_isLoading) {
      return;
    }
    _isLoading = true;
    _history$.add(null);
    updateTimeMode(SelectedTimeMode.Hourly);
    final PrivateData _privateData =
        await PrivateData.fromAssets("privateData.json");
    final String _url =
        "https://min-api.cryptocompare.com/data/histohour?fsym=" +
            _symbol +
            "&tsym=USD&limit=7&api_key=" +
            _privateData.apiKey;

    final _response = await http.get(_url);
    final Map<String, dynamic> _json = jsonDecode(_response.body);
    final History _history = History.fromJson(_json);
    _history$.add(_history);
    _isLoading = false;
  }

  void refreshLoadingStatus() {
    _isLoading$.add(_isLoading);
  }

  void updateTimeMode(SelectedTimeMode mode) {
    _timeMode$.add(mode);
  }

  void dispose() {
    _history$.close();
    _timeMode$.close();
    _isLoading$.close();
  }
}
