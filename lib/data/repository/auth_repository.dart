import 'package:pertemuan_2/data/model/login.dart';
import 'package:pertemuan_2/data/model/user.dart';

abstract interface class AuthRepository {
  Future<Login> login({
    required String phoneNumber,
    required String password,
  });

  Future<User> getProfile();
}