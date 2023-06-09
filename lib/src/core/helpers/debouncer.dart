
import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({
    required this.milliseconds,
  });

  void call(VoidCallback callBack) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), callBack);
  }
}
