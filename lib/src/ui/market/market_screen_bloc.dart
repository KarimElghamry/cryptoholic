import 'package:rxdart/rxdart.dart';

class MarketScreenBloc {
  BehaviorSubject<bool> _isTyping$;

  BehaviorSubject<bool> get isTyping$ => _isTyping$;

  MarketScreenBloc() {
    _isTyping$ = BehaviorSubject<bool>.seeded(false);
  }

  void changeTypingState(bool value) {
    _isTyping$.add(value);
  }

  void dispose() {
    _isTyping$.close();
  }
}
