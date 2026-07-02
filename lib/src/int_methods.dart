import 'helper.dart' as h;

/// Extension methods for integers
extension HeartInt on int {
  /// Returns character from character code.
  ///
  /// 97.chr returns 'a'.
  ///
  /// Invalid codes return empty.
  String get chr => h.chr(this);
}
