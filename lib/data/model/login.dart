
import 'user.dart';

class Login {
  User user;
  String token;

  Login({
    required this.user,
    required this.token,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
  };
}

