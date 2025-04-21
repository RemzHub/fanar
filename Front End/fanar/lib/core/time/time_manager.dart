import 'package:intl/intl.dart';

class TimeManager {
  late DateFormat dateFormat;

  // Private constructor
  TimeManager._() {
    dateFormat = DateFormat('y-M-d hh:mm:ss');
  }

  // static instance
  static final TimeManager _instance = TimeManager._();

  // Getter to access the instance
  static TimeManager instance = _instance;

  String timeNow() {
    final now = DateTime.now();
    return dateFormat.format(now);
  }
}
