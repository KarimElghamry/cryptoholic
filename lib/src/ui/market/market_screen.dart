import 'package:cryptoholic/src/blocs/global.dart';
import 'package:cryptoholic/src/models/coin.dart';
import 'package:cryptoholic/src/ui/coin_info/coin_info_screen.dart';
import 'package:cryptoholic/src/ui/common/crypto_loading_indicator.dart';
import 'package:cryptoholic/src/ui/market/coin_card.dart';
import 'package:cryptoholic/src/ui/market/market_screen_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketScreen extends StatefulWidget {
  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  ScrollController _scrollController;
  TextEditingController _textEditingController;
  MarketScreenBloc _marketScreenBloc;

  @override
  void initState() {
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
    _marketScreenBloc = MarketScreenBloc();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _marketScreenBloc.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<List<Coin>>(
        stream: _globalBloc.coinsBloc.coins$,
        builder: (BuildContext context, AsyncSnapshot<List<Coin>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CryptoLoadingIndicator(),
            );
          }

          final List<Coin> _coins = snapshot.data;
          return Stack(
            children: <Widget>[
              RefreshIndicator(
                color: Color(0xFF4CDA63),
                onRefresh: () {
                  _textEditingController.text = "";
                  _marketScreenBloc.changeTypingState(false);
                  return _globalBloc.coinsBloc.getCoins();
                },
                child: ListView.separated(
                  key: PageStorageKey("Market"),
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  itemCount: _coins.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFF4F3F7),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          key: UniqueKey(),
                          controller: _textEditingController,
                          maxLines: 1,
                          cursorColor: Color(0xFF4CDA63),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16.0),
                            hintText: "Search for currency",
                            hintMaxLines: 1,
                            hintStyle: TextStyle(
                              color: Color(0xFF8F8F91),
                            ),
                            border: InputBorder.none,
                            suffixIcon: StreamBuilder<bool>(
                                stream: _marketScreenBloc.isTyping$,
                                builder: (BuildContext context,
                                    AsyncSnapshot<bool> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  }
                                  final bool _isTyping = snapshot.data;
                                  return IconButton(
                                    onPressed: () => _globalBloc.coinsBloc
                                        .filterCoins(
                                            _textEditingController.text),
                                    icon: Icon(
                                      Icons.search,
                                      color: _isTyping
                                          ? Color(0xFF4CDA63)
                                          : Color(0xFF8F8F91),
                                    ),
                                  );
                                }),
                          ),
                          onSubmitted: (String value) =>
                              _globalBloc.coinsBloc.filterCoins(value),
                          onChanged: (String value) {
                            if (value.trim().length == 0) {
                              _marketScreenBloc.changeTypingState(false);
                            } else {
                              _marketScreenBloc.changeTypingState(true);
                            }
                          },
                        ),
                      );
                    }
                    final Coin _coin = _coins[index - 1];
                    return CoinCard(
                        key: UniqueKey(),
                        coin: _coin,
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (BuildContext context) => CoinInfoScreen(
                                coin: _coin,
                              ),
                            ),
                          );
                        });
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      width: double.infinity,
                      height: 15,
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton(
                    onPressed: () => _scrollController.animateTo(0,
                        duration: Duration(milliseconds: 750),
                        curve: Curves.easeInCubic),
                    backgroundColor: Color(0xFF4CDA63),
                    foregroundColor: Colors.white,
                    elevation: 0.0,
                    child: Icon(
                      Icons.arrow_upward,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
