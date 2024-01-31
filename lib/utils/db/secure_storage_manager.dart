import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

class SecureStorageManager {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  final String _tokenKey = 'token';

  Future<bool> isLoggedIn() async {
    return (await getToken() != '');
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: _tokenKey);
  }

  Future setToken({required String? value}) async {
    return await secureStorage.write(key: _tokenKey, value: value);
  }

  Future logout() async {
    await setToken(value: '');
  }
}
