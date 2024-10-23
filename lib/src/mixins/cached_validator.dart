import 'package:fform/fform.dart';

/// A mixin that caches the validation results.
mixin ValidationCachingMixin<T, E> on FFormField<T, E> {
  static const int _cacheSizeLimit = 50;

  final Map<String, E?> _cachedExceptions = <String, E?>{};

  @override
  Future<bool> check() async {
    final key = value.toString();
    if (_cachedExceptions.containsKey(key)) {
      exception = _cachedExceptions[key];
      return false;
    }

    await super.check();

    _cachedExceptions[key] = exception;

    if (_cachedExceptions.length > _cacheSizeLimit) {
      _cachedExceptions.remove(_cachedExceptions.keys.first);
    }

    return isValid;
  }
}
