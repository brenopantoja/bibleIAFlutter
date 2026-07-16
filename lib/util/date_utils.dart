import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static String format(
    DateTime date,
  ) {
    final locale =
        BibleProvider.instance.english
            ? 'en_US'
            : 'pt_BR';

    final pattern =
        BibleProvider.instance.english
            ? 'MM/dd/yyyy hh:mm:ss a'
            : 'dd/MM/yyyy HH:mm:ss';

    return DateFormat(
      pattern,
      locale,
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