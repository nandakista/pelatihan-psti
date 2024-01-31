import 'package:flutter/material.dart';
import 'package:pertemuan_2/pages/benefit/benefit_list_page.dart';
import 'package:pertemuan_2/pages/login/login_page.dart';
import 'package:pertemuan_2/utils/db/secure_storage_manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final secureStorageManager = SecureStorageManager();

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  void checkToken() async {
    await Future.delayed(Duration(seconds: 1));
    bool isLogin = await secureStorageManager.isLoggedIn();
    if (isLogin) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, BenefitListPage.route);
      }
    } else {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, LoginPage.route);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: FlutterLogo(
          size: 300,
        ),
      ),
    );
  }
}
