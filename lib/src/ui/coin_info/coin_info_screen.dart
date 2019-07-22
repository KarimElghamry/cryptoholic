import 'package:cryptoholic/src/models/coin.dart';
import 'package:cryptoholic/src/models/selected_time_mode.dart';
import 'package:cryptoholic/src/ui/coin_info/coin_info_bloc.dart';
import 'package:cryptoholic/src/ui/coin_info/custom_widgets.dart';
import 'package:cryptoholic/src/ui/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinInfoScreen extends StatelessWidget {
  final Coin _coin;
  final double _appBarHeight = 150;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CoinInfoScreen({@required Coin coin}) : _coin = coin;

  @override
  Widget build(BuildContext context) {
    final _coinInfoBloc = CoinInfoBloc(_coin.coinInfo.symbol);
    _spamSnackBar(_coinInfoBloc);

    return Provider(
      builder: (BuildContext context) => _coinInfoBloc,
      dispose: (BuildContext context, CoinInfoBloc bloc) => bloc.dispose(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, _appBarHeight),
          child: CryptoholicAppBar(
            title: _coin.coinInfo.fullName,
            height: _appBarHeight,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Material(
                type: MaterialType.transparency,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  splashColor: Colors.white,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
            action: Container(),
          ),
        ),
        body: ListView(
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFF4CDA63),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Current Price \nof ${_coin.coinInfo.symbol}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "\$ ${_coin.coinStats.price.toStringAsFixed(3)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TimeModeButton(
                        mode: SelectedTimeMode.Daily,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TimeModeButton(
                        mode: SelectedTimeMode.Hourly,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.2,
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: StreamBuilder<SelectedTimeMode>(
                stream: _coinInfoBloc.timeMode$,
                builder: (BuildContext context,
                    AsyncSnapshot<SelectedTimeMode> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  final SelectedTimeMode _mode = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22.0),
                    child: CoinInfoGraph(
                      key: UniqueKey(),
                      mode: _mode,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: FlatButton(
                    color: Color(0xFF4CDA63),
                    child: Text(
                      "Buy ${_coin.coinInfo.fullName}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      _showSnackBar("this feature is coming soon.");
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _spamSnackBar(CoinInfoBloc _coinInfoBloc) {
    _coinInfoBloc.isLoading$.listen(
      (bool isLoading) {
        if (isLoading) {
          _showSnackBar("Loading in progress, don't spam.");
        }
      },
    );
  }

  void _showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        duration: Duration(milliseconds: 1500),
        content: Text(title),
      ),
    );
  }
}
