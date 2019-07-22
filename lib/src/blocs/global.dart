import 'package:cryptoholic/src/blocs/coins.dart';

class GlobalBloc {
  CoinsBloc _coinsBloc;

  CoinsBloc get coinsBloc => _coinsBloc;

  GlobalBloc() {
    _coinsBloc = CoinsBloc();
  }

  void dispose() {
    _coinsBloc.dispose();
  }
}
