import 'package:flutter/material.dart';
import 'package:pertemuan_2/pages/benefit/benefit_detail_page.dart';
import 'package:pertemuan_2/pages/benefit/benefit_list_page.dart';

void main() {
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
          case BenefitListPage.route:
            return MaterialPageRoute(builder: (_) => const BenefitListPage());
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
      home: const BenefitListPage(),
    );
  }
}
