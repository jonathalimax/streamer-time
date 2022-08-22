import 'dart:io';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class UserLocale {
  static LocaleType locale() {
    switch (Platform.localeName) {
      case 'en':
        return LocaleType.en;
      case 'es':
        return LocaleType.es;
      case 'pt':
        return LocaleType.pt;
      default:
        return LocaleType.pt;
    }
  }
}
