import 'package:bezier_chart/bezier_chart.dart';
import 'package:cryptoholic/src/models/history.dart';
import 'package:cryptoholic/src/models/selected_time_mode.dart';
import 'package:cryptoholic/src/ui/coin_info/coin_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinInfoGraph extends StatelessWidget {
  const CoinInfoGraph({
    Key key,
    @required SelectedTimeMode mode,
  })  : _mode = mode,
        super(key: key);

  final SelectedTimeMode _mode;
  @override
  Widget build(BuildContext context) {
    final CoinInfoBloc _coinInfoBloc = Provider.of<CoinInfoBloc>(context);
    return StreamBuilder<History>(
      key: UniqueKey(),
      stream: _coinInfoBloc.history$,
      builder: (BuildContext context, AsyncSnapshot<History> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final History _history = snapshot.data;
        final DateTime _dateFrom = DateTime.fromMillisecondsSinceEpoch(
          num.parse(
            (_history.timeFrom.toString() + "000"),
          ),
        );
        final DateTime _dateTo = DateTime.fromMillisecondsSinceEpoch(
          num.parse(
            (_history.timeTo.toString() + "000"),
          ),
        );
        List<DataPoint<DateTime>> _pricePoints = [];
        List<DataPoint<DateTime>> _highPoints = [];
        List<DataPoint<DateTime>> _lowPoints = [];
        for (var item in _history.graphData) {
          final num _price = item.open.toDouble();
          final num _high = item.high.toDouble();
          final num _low = item.low.toDouble();
          final DateTime _time = DateTime.fromMillisecondsSinceEpoch(
            num.parse(item.time.toString() + "000"),
          );
          _pricePoints.add(
            DataPoint<DateTime>(value: _price, xAxis: _time),
          );
          _highPoints.add(
            DataPoint<DateTime>(value: _high, xAxis: _time),
          );
          _lowPoints.add(
            DataPoint<DateTime>(value: _low, xAxis: _time),
          );
        }
        return BezierChart(
          key: UniqueKey(),
          fromDate: _dateFrom,
          toDate: _dateTo,
          bezierChartScale: _mode == SelectedTimeMode.Daily
              ? BezierChartScale.WEEKLY
              : BezierChartScale.HOURLY,
          selectedDate: _dateTo,
          series: [
            BezierLine(
              label: "Open",
              data: _pricePoints,
              lineColor: Colors.green,
              lineStrokeWidth: 5,
            ),
            BezierLine(
              label: "High",
              data: _highPoints,
              lineColor: Colors.black,
              lineStrokeWidth: 5,
            ),
            BezierLine(
              label: "Low",
              data: _lowPoints,
              lineColor: Colors.red,
              lineStrokeWidth: 5,
            ),
          ],
          config: BezierChartConfig(
            bubbleIndicatorColor: Colors.green,
            bubbleIndicatorValueStyle: TextStyle(color: Colors.white),
            bubbleIndicatorLabelStyle: TextStyle(color: Colors.white),
            bubbleIndicatorTitleStyle: TextStyle(color: Colors.white),
            verticalIndicatorStrokeWidth: 1.0,
            showDataPoints: true,
            verticalIndicatorColor: Colors.black,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            backgroundColor: Colors.transparent,
            footerHeight: 50,
            displayLinesXAxis: true,
            xLinesColor: Colors.red,
            xAxisTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
            snap: true,
          ),
        );
      },
    );
  }
}

class TimeModeButton extends StatelessWidget {
  const TimeModeButton({
    Key key,
    @required SelectedTimeMode mode,
  })  : _selectedMode = mode,
        super(key: key);

  final SelectedTimeMode _selectedMode;

  @override
  Widget build(BuildContext context) {
    final CoinInfoBloc _coinInfoBloc = Provider.of<CoinInfoBloc>(context);
    return StreamBuilder<SelectedTimeMode>(
        stream: _coinInfoBloc.timeMode$,
        builder:
            (BuildContext context, AsyncSnapshot<SelectedTimeMode> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          final SelectedTimeMode _mode = snapshot.data;
          return GestureDetector(
            onTap: () {
              _coinInfoBloc.updateTimeMode(_selectedMode);
              if (_selectedMode == SelectedTimeMode.Daily) {
                _coinInfoBloc.getDailyHistory();
              } else {
                _coinInfoBloc.getHourlyHistory();
              }
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              curve: Curves.linear,
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color:
                    _mode == _selectedMode ? Color(0xFFE7F9EA) : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  _selectedMode.toString().substring(17),
                  style: TextStyle(
                    color: _mode == _selectedMode
                        ? Color(0xFF82D991)
                        : Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
