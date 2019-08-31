import 'package:cryptoholic/src/blocs/coins.dart';
import 'package:cryptoholic/src/blocs/search_bloc.dart';

class GlobalBloc {
  CoinsBloc _coinsBloc;
  SearchBloc _searchBloc;

  CoinsBloc get coinsBloc => _coinsBloc;
  SearchBloc get searchBloc => _searchBloc;

  GlobalBloc() {
    _coinsBloc = CoinsBloc();
    _searchBloc = SearchBloc();
  }

  void dispose() {
    _coinsBloc.dispose();
    _searchBloc.dispose();
  }
}
