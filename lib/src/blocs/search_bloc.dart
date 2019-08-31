import 'package:rxdart/rxdart.dart';

class SearchBloc {
  BehaviorSubject<bool> _isTyping$;
  BehaviorSubject<String> _currentText$;

  BehaviorSubject<bool> get isTyping$ => _isTyping$;
  BehaviorSubject<String> get currentText$ => _currentText$;

  SearchBloc() {
    _isTyping$ = BehaviorSubject<bool>.seeded(false);
    _currentText$ = BehaviorSubject<String>.seeded("");
  }

  void changeTypingState(bool value) {
    _isTyping$.add(value);
  }

  void updateText(String text) {
    _currentText$.add(text);
  }

  void dispose() {
    _isTyping$.close();
    _currentText$.close();
  }
}
