import 'package:pertemuan_2/data/model/login.dart';

abstract interface class AuthRepository {
  Future<Login> login({
    required String phoneNumber,
    required String password,
  });
}