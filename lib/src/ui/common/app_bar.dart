import 'package:flutter/material.dart';

class CryptoholicAppBar extends StatelessWidget {
  final double _height;
  final Widget _leading;
  final Widget _action;
  final String _title;

  CryptoholicAppBar(
      {@required double height,
      @required Widget leading,
      @required Widget action,
      @required String title})
      : _height = height,
        _leading = leading,
        _action = action,
        _title = title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _height,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: _height,
            color: Color(0xFF4CDA63),
            child: Opacity(
              opacity: 0.7,
              child: CustomPaint(
                foregroundPainter: CurvedPath(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _leading,
                  _action,
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text(
                _title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedPath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint _line = Paint()
      ..color = Color(0XFF65DE7A)
      ..style = PaintingStyle.fill;

    Path _path = Path();

    _path.moveTo(0, size.height);
    _path.lineTo(0, size.height / 1.5);
    _path.quadraticBezierTo(size.width / 8.5, size.height / 2.05,
        size.width / 4, size.height / 1.8);
    _path.quadraticBezierTo(size.width / 2.4, size.height / 1.5, size.width / 2,
        size.height / 2.05);
    _path.quadraticBezierTo(size.width / 1.62, size.height / 7.9,
        (3 * size.width / 4), size.height / 2.7);
    _path.quadraticBezierTo(
        size.width / 1.2, size.height / 2, size.width, size.height / 2.9);

    _path.lineTo(size.width, size.height);

    canvas.drawPath(_path, _line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
