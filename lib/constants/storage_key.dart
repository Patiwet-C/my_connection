class StorageKey {
  StorageKey._();

  static const String cache = 'cache_';
  static String storageKey(String key) => '$cache$key';

  static const String data = 'data';
  static const String timestamp = 'timestamp';
  static const String expiration = 'expiration';

  static const String darkModeSetting = 'darkModeSetting';
  static const String languageSetting = 'languageSetting';
}
