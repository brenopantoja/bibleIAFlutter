import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static String format(
    DateTime date,
  ) {
    return DateFormat(
      'dd/MM/yyyy HH:mm:ss',
      'pt_BR',
    ).format(date);
  }

  static String formatFromString(
    String value,
  ) {
    return format(
      DateTime.parse(value),
    );
  }
}