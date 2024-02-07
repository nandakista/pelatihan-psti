import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pertemuan_2/pages/benefit/benefit_detail_page.dart';
import 'package:pertemuan_2/pages/benefit/benefit_list_page.dart';
import 'package:pertemuan_2/pages/login/login_page.dart';
import 'package:pertemuan_2/pages/profile/profile_page.dart';
import 'package:pertemuan_2/pages/splash/splash_page.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case ProfilePage.route :
            return MaterialPageRoute(builder: (_) => const ProfilePage());
          case BenefitListPage.route:
            return MaterialPageRoute(builder: (_) => const BenefitListPage());
          case LoginPage.route:
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case BenefitDetailPage.route:
            return MaterialPageRoute(
              builder: (_) => BenefitDetailPage(
                id: settings.arguments as int,
              ),
            );
          default:
            return MaterialPageRoute(
              builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Oops..\nPage not found :('),
                  ),
                );
              },
            );
        }
      },
      home: const SplashPage(),
    );
  }
}
