import 'package:cryptoholic/src/models/coin.dart';
import 'package:cryptoholic/src/ui/common/crypto_loading_indicator.dart';
import 'package:cryptoholic/src/ui/market/mini_graph.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CoinCard extends StatelessWidget {
  final Coin _coin;
  final VoidCallback _onPressed;

  CoinCard({Key key, @required Coin coin, @required VoidCallback onPressed})
      : _coin = coin,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _isPositive = _coin.coinStats.changeDay >= 0;
    return GestureDetector(
      onTap: _onPressed,
      child: Container(
        width: double.infinity,
        height: 85,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFF4F3F7),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 70,
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: _coin.coinInfo.imageUrl,
                    placeholder: (BuildContext context, _) => Center(
                      child: CryptoLoadingIndicator(),
                    ),
                    errorWidget: (BuildContext context, _, __) =>
                        Icon(Icons.error),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _coin.coinInfo.fullName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          softWrap: true,
                        ),
                        Container(
                          height: 6,
                        ),
                        Text(
                          _coin.coinInfo.symbol,
                          style: TextStyle(
                            color: Color(0xFFAAAAAC),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding:
                      EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0),
                  child: CustomPaint(
                    foregroundPainter: MiniGraph(coin: _coin),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "\$${_coin.coinStats.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.3,
                        ),
                        maxLines: 1,
                      ),
                      Container(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _coin.coinStats.changeDay.abs().toStringAsFixed(2),
                            style: TextStyle(
                              color: _isPositive
                                  ? Color(0xFF4CDA63)
                                  : Color(0xFFCC6061),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.3,
                            ),
                            maxLines: 1,
                          ),
                          Container(
                            width: 3,
                          ),
                          Icon(
                            _isPositive
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: _isPositive
                                ? Color(0xFF4CDA63)
                                : Color(0xFFCC6061),
                            size: 16,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
