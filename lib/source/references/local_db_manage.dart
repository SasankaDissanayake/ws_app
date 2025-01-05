import 'package:get_storage/get_storage.dart';

class LocalDbManager {
  static final _storage = GetStorage();

  static Future<void> saveData(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  static dynamic getData(String key) {
    return _storage.read(key);
  }
}
