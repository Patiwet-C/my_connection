import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:my_connection/constants/storage_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStorage {
  String getString(String key);

  Future<void> saveString({required String key, required String value});

  Future<void> delete({required String key});

  // Enhanced caching methods
  Future<void> cacheData<T>({
    required String key,
    required T data,
    Duration? expiration,
  });
  T? getCachedData<T>(String key);
  bool isCacheValid(String key);
  Future<void> clearExpiredCache();
  Future<void> clearAllCache();
}

@injectable
class LocalStorage implements ILocalStorage {
  final SharedPreferences _storage;

  LocalStorage(this._storage);

  @override
  String getString(String key) {
    final String? data = _storage.getString(key);
    return data ?? '';
  }

  @override
  Future<void> saveString({required String key, required String value}) async {
    await _storage.setString(key, value);
  }

  @override
  Future<void> delete({required String key}) async {
    await _storage.remove(StorageKey.storageKey(key));
  }

  // Enhanced caching methods
  @override
  Future<void> cacheData<T>({
    required String key,
    required T data,
    Duration? expiration,
  }) async {
    final cacheEntry = {
      StorageKey.data: data,
      StorageKey.timestamp: DateTime.now().millisecondsSinceEpoch,
      StorageKey.expiration: expiration?.inMilliseconds,
    };

    await saveString(
      key: StorageKey.storageKey(key),
      value: jsonEncode(cacheEntry),
    );
  }

  @override
  T? getCachedData<T>(String key) {
    final cacheJson = getString(StorageKey.storageKey(key));
    if (cacheJson.isEmpty) return null as T?;

    try {
      final cacheEntry = jsonDecode(cacheJson) as Map<String, dynamic>;

      if (!isCacheValid(key)) {
        delete(key: StorageKey.storageKey(key));
        return null as T?;
      }

      return cacheEntry[StorageKey.data] as T?;
    } catch (e) {
      return null as T?;
    }
  }

  @override
  bool isCacheValid(String key) {
    final cacheJson = getString(StorageKey.storageKey(key));
    if (cacheJson.isEmpty) return false;

    try {
      final cacheEntry = jsonDecode(cacheJson) as Map<String, dynamic>;
      final timestamp = cacheEntry[StorageKey.timestamp] as int;
      final expiration = cacheEntry[StorageKey.expiration] as int?;

      if (expiration == null) return true; // No expiration set

      final now = DateTime.now().millisecondsSinceEpoch;
      return (now - timestamp) < expiration;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearExpiredCache() async {
    final keys = _storage.getKeys();
    final cacheKeys = keys.where((key) => key.startsWith(StorageKey.cache));

    for (final key in cacheKeys) {
      final actualKey = key.replaceFirst(StorageKey.cache, '');
      if (!isCacheValid(actualKey)) {
        await delete(key: key);
      }
    }
  }

  @override
  Future<void> clearAllCache() async {
    final keys = _storage.getKeys();
    final cacheKeys = keys.where((key) => key.startsWith(StorageKey.cache));

    for (final key in cacheKeys) {
      await delete(key: key);
    }
  }
}
