import 'package:flutter/material.dart';

import 'font_provider.dart';

class FontConsumer extends InheritedNotifier<FontProvider> {
   FontConsumer({
    super.key,
    required super.child,
  }) : super(
          notifier: FontProvider.instance,
        );

  static FontProvider of(
    BuildContext context,
  ) {
    return context
        .dependOnInheritedWidgetOfExactType<FontConsumer>()!
        .notifier!;
  }
}