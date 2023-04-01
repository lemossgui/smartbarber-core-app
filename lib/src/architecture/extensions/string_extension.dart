import 'package:diacritic/diacritic.dart';
import 'package:intl/intl.dart';

extension NullableStringExtensions on String? {
  bool get isNullOrEmpty {
    return this == null || this?.isEmpty == true;
  }

  bool get hasValue {
    return !isNullOrEmpty;
  }

  DateTime? toDateTime() {
    if (this != null) {
      final formatter = DateFormat('dd/MM/yyyy');
      return formatter.parse(this!);
    }
    return null;
  }

  int? toInt() {
    if (this != null) {
      return int.parse(this!);
    }
    return null;
  }

  double? toDouble() {
    if (this != null) {
      return double.parse(this!);
    }
    return null;
  }
}

extension StringExtensions on String {
  String get stripAccents {
    return removeDiacritics(this);
  }

  String get stripAccentsAndUpperCase {
    return removeDiacritics(this).toUpperCase();
  }
}
