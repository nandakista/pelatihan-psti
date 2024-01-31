import 'dart:convert';
import 'dart:developer';

import 'package:pertemuan_2/data/model/login.dart';
import 'package:pertemuan_2/data/repository/auth_repository.dart';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Login> login({required String phoneNumber, required String password}) async {
    try {
      Uri uri = Uri.parse('https://dancare-staging.saharsa-tech.com/api/auth/login');
      final response = await http.post(
        uri,
        body: {
          'login': phoneNumber,
          'password': password,
        },
      );

      print('response ${response.body}');
      final responseBody = jsonDecode(response.body);

      final responseData = Login.fromJson(responseBody['data']);
      return responseData;
    } catch (e) {
      log('Error $e');
      rethrow;
    }
  }
}