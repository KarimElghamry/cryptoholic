import 'package:rxdart/rxdart.dart';

class HomeScreenBloc {
  BehaviorSubject<int> _pageIndex$;

  BehaviorSubject<int> get pageIndex$ => _pageIndex$;

  HomeScreenBloc() {
    _pageIndex$ = BehaviorSubject<int>.seeded(0);
  }

  updatePageIndex(int index) {
    _pageIndex$.add(index);
  }

  void dispose() {
    _pageIndex$.close();
  }
}
