import 'package:cryptoholic/src/blocs/global.dart';
import 'package:cryptoholic/src/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Cryptoholic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Provider(
      builder: (BuildContext context) => GlobalBloc(),
      dispose: (BuildContext context, GlobalBloc bloc) => bloc.dispose(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textSelectionColor: Color(0xFF4CDA63).withOpacity(0.7),
          textSelectionHandleColor: Color(0xFF4CDA63),
          accentColor: Color(0xFF4CDA63),
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
