import 'package:shared_preferences/shared_preferences.dart';

abstract class Keys {
  static const url = 'url_address';
}

class DataProvider {
  static final _storage = SharedPreferences.getInstance();

  Future<String?> getUrl() async {
    final data = (await _storage).getString(Keys.url);
    return data;
  }

  Future<void> setUrl(String value) async {
    (await _storage).setString(Keys.url, value);
  }
}