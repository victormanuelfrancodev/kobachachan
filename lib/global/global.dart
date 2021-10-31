import 'package:flutter/foundation.dart' show kIsWeb;

class Global {
  static var TOTAL_LIFES = 5;
  static var JUMP = kIsWeb ? -300 : -145;
  static var CANDYS_COUNTER = 0;
  static var MULTIPLIER_CANDYS = 1;
}