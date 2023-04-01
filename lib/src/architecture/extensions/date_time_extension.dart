import 'package:intl/intl.dart';

extension DateTimeNullableExtension on DateTime? {
  String? toDisplay() {
    final value = this;
    if (value != null) {
      return value.toDisplay();
    }
    return null;
  }

  String? toDisplayDate() {
    final value = this;
    if (value != null) {
      return value.toDisplayDate();
    }
    return null;
  }

  String? toDisplayTime() {
    final value = this;
    if (value != null) {
      return value.toDisplayTime();
    }
    return null;
  }
}

extension DateTimeExtension on DateTime {
  String toDisplay() {
    final formatter = DateFormat("dd/MM 'às' HH:mm");
    return formatter.format(this);
  }

  String toDisplayDate() {
    final formatter = DateFormat('dd/MM');
    return formatter.format(this);
  }

  String toDisplayTime() {
    final formatter = DateFormat('HH:mm');
    return formatter.format(this);
  }

  String get dayOfWeek {
    return weekDays.entries.firstWhere((item) => item.key == weekday).value;
  }

  String get monthDescription {
    return months.entries.firstWhere((item) => item.key == month).value;
  }
}

Map<int, String> weekDays = {
  0: 'Dom',
  1: 'Seg',
  2: 'Ter',
  3: 'Qua',
  4: 'Qui',
  5: 'Sex',
  6: 'Sáb',
};

Map<int, String> months = {
  1: 'jan',
  2: 'fev',
  3: 'mar',
  4: 'abr',
  5: 'jun',
  6: 'jul',
  7: 'ago',
  8: 'ago',
  9: 'set',
  10: 'out',
  11: 'nov',
  12: 'dez',
};
