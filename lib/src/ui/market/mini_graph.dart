import 'package:cryptoholic/src/models/coin.dart';
import 'package:flutter/material.dart';

class MiniGraph extends CustomPainter {
  final Coin _coin;

  MiniGraph({@required Coin coin}) : _coin = coin;

  @override
  void paint(Canvas canvas, Size size) {
    final num _maxPrice = _coin.coinStats.highDay;
    final num _minPrice = _coin.coinStats.lowDay;
    final num _range = (_maxPrice - _minPrice);
    final num _normalizedFinalPrice =
        _maxPrice - (_coin.coinStats.price + _coin.coinStats.changeDay);
    final num _normalizedOpenPrice = _maxPrice - _coin.coinStats.openDay;
    final bool _isPositive = _coin.coinStats.changeDay >= 0;

    Paint _line = Paint()
      ..color = _isPositive ? Color(0xFF4CDA63) : Color(0xFFCC6061)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Path _path = Path();

    _path.moveTo(
      0,
      ((_normalizedOpenPrice / _range) * size.height).toDouble(),
    );

    if (_isPositive) {
      _path.quadraticBezierTo(size.width / 8, 0, size.width / 4, 0);

      _path.quadraticBezierTo((3 * size.width) / 8, 0, size.width / 2,
          ((_maxPrice - _coin.coinStats.lowDay) / _range) * size.height * 0.58);

      _path.quadraticBezierTo(
          (5 * size.width) / 8, size.height, (3 * size.width) / 4, size.height);
    } else {
      _path.quadraticBezierTo(size.width / 8, size.height, size.width / 4,
          ((_maxPrice - _coin.coinStats.lowDay) / _range) * size.height);

      _path.quadraticBezierTo((3 * size.width) / 8, size.height, size.width / 2,
          0.42 * size.height);

      _path.quadraticBezierTo((5 * size.width) / 8, 0, (3 * size.width) / 4, 0);
    }

    num _endPoint;
    if (_normalizedFinalPrice / _range >= 1) {
      _endPoint = size.height;
    } else if (_normalizedFinalPrice / _range <= 0) {
      _endPoint = 0;
    } else {
      _endPoint = (_normalizedFinalPrice / _range) * size.height;
    }

    _path.quadraticBezierTo(
      (7 * size.width) / 8,
      _isPositive ? size.height : 0,
      size.width,
      _endPoint.toDouble(),
    );

    canvas.drawPath(_path, _line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
}
