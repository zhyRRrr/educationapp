import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  Timer? _timer;
  int _counter = 0;
  final int _maxTime = 3600; // 1小时（3600秒）
  bool _isDialogShown = false;

  TimerProvider() {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _counter++;

      if (_counter >= _maxTime && !_isDialogShown) {
        _isDialogShown = true;
        notifyListeners();
      }
    });
  }

  void resetDialogFlag() {
    _isDialogShown = false;
  }

  bool get shouldShowDialog => _isDialogShown;

  String get elapsedTime {
    int hours = _counter ~/ 3600;
    int minutes = (_counter % 3600) ~/ 60;
    int seconds = _counter % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
