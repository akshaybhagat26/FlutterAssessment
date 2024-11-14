import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void navigateToScreen(Widget screen, {bool isReplace = false}) {
    if (isReplace) {
      Navigator.pushAndRemoveUntil(
          this, MaterialPageRoute(builder: (_) => screen), (route) => false);
    } else {
      Navigator.push(this, MaterialPageRoute(builder: (_) => screen));
    }
  }

  double getWidth({double percentage = 1}) {
    return MediaQuery.of(this).size.width * percentage;
  }

  double getHeight({double percentage = 1}) {
    return MediaQuery.of(this).size.height * percentage;
  }
}
