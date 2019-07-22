import 'package:cryptoholic/src/ui/coming_soon/coming_soon_screen.dart';
import 'package:cryptoholic/src/ui/common/app_bar.dart';
import 'package:cryptoholic/src/ui/common/custom_icons.dart';
import 'package:cryptoholic/src/ui/home/bottom_sheet_settings.dart';
import 'package:cryptoholic/src/ui/home/home_screen_bloc.dart';
import 'package:cryptoholic/src/ui/market/market_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc _homeScreenBloc;
  double _appBarHeight;
  GlobalKey<ScaffoldState> _scaffoldKey;
  List<String> _titles;

  @override
  void initState() {
    _homeScreenBloc = HomeScreenBloc();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _appBarHeight = 150;
    _titles = ["Market", "Wallet", "Account"];
    super.initState();
  }

  @override
  void dispose() {
    _homeScreenBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, _appBarHeight),
        child: StreamBuilder<int>(
            stream: _homeScreenBloc.pageIndex$,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              final _index = snapshot.data;
              return CryptoholicAppBar(
                title: _titles[_index],
                height: _appBarHeight,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Material(
                    type: MaterialType.transparency,
                    child: IconButton(
                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
                      splashColor: Colors.white,
                      icon: Icon(
                        CustomIcons.menuCustomIcon,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                action: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Material(
                    type: MaterialType.transparency,
                    child: IconButton(
                      onPressed: () => settingModalBottomSheet(context),
                      splashColor: Colors.white,
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
      drawer: Drawer(),
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1.5,
              color: Color(0xFFF4F3F7),
            ),
          ),
        ),
        child: StreamBuilder<int>(
            stream: _homeScreenBloc.pageIndex$,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              final int _index = snapshot.data;
              return BottomNavigationBar(
                onTap: (int index) => _homeScreenBloc.updatePageIndex(index),
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 12.0,
                unselectedFontSize: 12.0,
                selectedItemColor: Color(0xFF6BC076),
                unselectedItemColor: Color(0xFF8F8F91),
                iconSize: 26,
                currentIndex: _index,
                elevation: 0,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    title: Text(_titles[0]),
                    icon: Icon(Icons.attach_money),
                  ),
                  BottomNavigationBarItem(
                    title: Text(_titles[1]),
                    icon: Icon(Icons.account_balance_wallet),
                  ),
                  BottomNavigationBarItem(
                    title: Text(_titles[2]),
                    icon: Icon(Icons.person_outline),
                  ),
                ],
              );
            }),
      ),
      body: StreamBuilder<int>(
        stream: _homeScreenBloc.pageIndex$,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final int _index = snapshot.data;

          switch (_index) {
            case 0:
              return MarketScreen();
              break;
            case 1:
              return ComingSoonScreen();
              break;
            case 2:
              return ComingSoonScreen();
              break;
            default:
              return MarketScreen();
          }
        },
      ),
    );
  }
}
