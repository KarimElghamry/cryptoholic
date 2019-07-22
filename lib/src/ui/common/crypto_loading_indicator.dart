import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class CryptoLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 200,
        maxWidth: 200,
      ),
      child: FlareActor(
        "assets/animations/loading_indicator.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "animation",
      ),
    );
  }
}
