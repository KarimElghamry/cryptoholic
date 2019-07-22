import 'package:cryptoholic/src/blocs/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void settingModalBottomSheet(context) {
  final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 130,
        width: double.infinity,
        child: Center(
          child: StreamBuilder<int>(
            stream: _globalBloc.coinsBloc.maxListSize$,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              final int _value = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Set the size of coins list",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  Slider(
                    min: 10,
                    max: 100,
                    divisions: 90,
                    label: "List size: $_value",
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    value: _value.toDouble(),
                    onChanged: (value) {
                      _globalBloc.coinsBloc.setMaxListSize(
                        value.toInt(),
                      );
                    },
                  ),
                  Center(
                    child: Text(
                      "refresh to take effect.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
