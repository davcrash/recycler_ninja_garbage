import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

final numberFormatter = NumberFormat('#,###');

bool isPlatformBigScreen() {
  try {
    return Platform.isWindows || Platform.isMacOS || kIsWeb;
  } catch (e) {
    return false;
  }
}
