import 'package:intl/intl.dart';

extension DoubleFunctions on double {
  String get currency {
    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");
    return formatter.format(this);
  }

  String get toTime {
    String getMinuteString(double decimalValue) {
      final result = '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
      return result == '00' ? '0' : result;
    }

    String getHourString(int flooredValue) {
      final result = '${flooredValue % 24}'.padLeft(2, '0');
      return result == '00' ? '0' : result;
    }

    if (this < 0) return 'Invalid Value';
    int flooredValue = floor();
    double decimalValue = this - flooredValue;
    String hourValue = getHourString(flooredValue);
    String minuteString = getMinuteString(decimalValue);

    return '${hourValue}h ${minuteString}m';
  }
}
