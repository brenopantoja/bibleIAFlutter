import 'package:bibliaia/core/providers/font_provider.dart';

class AppFont {
  static double get body =>
      FontProvider.instance.fontSize;

  static double get title =>
      FontProvider.instance.fontSize + 2;

  static double get subtitle =>
      FontProvider.instance.fontSize - 2;

  static double get caption =>
      FontProvider.instance.fontSize - 5;

  static double get h1 =>
      FontProvider.instance.fontSize + 10;

  static double get h2 =>
      FontProvider.instance.fontSize + 6;

  static double get h3 =>
      FontProvider.instance.fontSize + 3;
}