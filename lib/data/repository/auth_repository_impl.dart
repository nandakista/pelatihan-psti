import 'dart:convert';
import 'dart:developer';

import 'package:pertemuan_2/data/model/login.dart';
import 'package:pertemuan_2/data/model/user.dart';
import 'package:pertemuan_2/data/repository/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:pertemuan_2/utils/db/secure_storage_manager.dart';
import 'package:pertemuan_2/utils/db/storage_manager.dart';

class AuthRepositoryImpl implements AuthRepository {
  StorageManager localDb = StorageManager();

  @override
  Future<Login> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      Uri uri =
          Uri.parse('https://dancare-staging.saharsa-tech.com/api/auth/login');
      final response = await http.post(
        uri,
        body: {
          'login': phoneNumber,
          'password': password,
        },
      );

      log('response ${response.body}');
      final responseBody = jsonDecode(response.body);

      final responseData = Login.fromJson(responseBody['data']);
      return responseData;
    } catch (e) {
      log('Error $e');
      rethrow;
    }
  }

  @override
  Future<User> getProfile() async {
    try {
      Map<String, dynamic>? cache = await localDb.get('user');
      if (cache == null) {
        await Future.delayed(const Duration(seconds: 2));
        User userResponse = await _getProfileFromAPI();
        await localDb.save('user', userResponse.toJson());
        return userResponse;
      } else {
        log('GET from Cache');
        User? user = User.fromJson(cache);
        _getProfileFromAPI().then(
          (value) => localDb.save(
            'user',
            value.toJson(),
          ),
        );
        return user;
      }
    } catch (e, stack) {
      log('Error $e, $stack');
      rethrow;
    }
  }

  Future<User> _getProfileFromAPI() async {
    try {
      Uri uri = Uri.parse(
          'https://dancare-staging.saharsa-tech.com/api/user/profile');
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer ${await SecureStorageManager().getToken()}',
        },
      );

      log('response ${response.body}');
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final responseData = User.fromJson(responseBody['data']);
        return responseData;
      } else {
        throw responseBody['message'];
      }
    } catch (e) {
      log('Error $e');
      rethrow;
    }
  }
}
