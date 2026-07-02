import 'helper.dart' as h;

/// Extension methods for Maps
extension HeartMap<K, V> on Map<K, V> {
  /// Returns the same Map with the keys sorted in ascending order.
  ///
  /// {9: 5, 1: 2, 4: 8}.ascendingKeys returns {1: 2, 4: 8, 9: 5}.
  Map<K, V> get ascendingKeys => h.ascendingKeysMap(this);

  /// Return the same Map with the keys sorted in descending order.
  ///
  /// {9: 5, 1: 2, 4: 8}.descendingKeys returns {9: 5, 4: 8, 1: 2}.
  Map<K, V> get descendingKeys => h.descendingKeysMap(this);

  /// Return the same Map with the values sorted in ascending order.
  ///
  /// {9: 5, 1: 2, 4: 8}.ascendingValues returns {1: 2, 9: 5, 4: 8}.
  Map<K, V> get ascendingValues => h.ascendingValuesMap(this);

  /// Return the same Map with the values sorted in descending order.
  ///
  /// {9: 5, 1: 2, 4: 8}.descendingValues returns {4: 8, 9: 5, 1: 2}.
  Map<K, V> get descendingValues => h.descendingValuesMap(this);
}
