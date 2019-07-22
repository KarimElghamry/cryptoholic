class GraphData {
  num _time;
  num _close;
  num _high;
  num _low;
  num _open;

  num get time => _time;
  num get close => _close;
  num get high => _high;
  num get low => _low;
  num get open => _open;

  GraphData._({num time, num close, num high, num low, num open})
      : _time = time,
        _close = close,
        _high = high,
        _low = low,
        _open = open;

  factory GraphData.fromJson(Map<String, dynamic> json) {
    return GraphData._(
      time: json["time"],
      close: json["close"],
      high: json["high"],
      low: json["low"],
      open: json["open"],
    );
  }
}
