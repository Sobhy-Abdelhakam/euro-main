import 'package:euro/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

class S {
  static AppLocalizations? _current;

  /// Use inside widgets
  static AppLocalizations of(BuildContext context) {
    _current = AppLocalizations.of(context)!;
    return _current!;
  }

  /// Backward compatibility for S.current
  static AppLocalizations get current {
    if (_current == null) {
      throw FlutterError(
        'S.current was called before localization was initialized.\n'
        'Use S.of(context) inside widgets.'
      );
    }
    return _current!;
  }
}

