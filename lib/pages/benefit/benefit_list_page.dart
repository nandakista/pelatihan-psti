import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pertemuan_2/pages/benefit/benefit_detail_page.dart';
import 'package:http/http.dart' as http;

class BenefitListPage extends StatefulWidget {
  static const route = '/list';

  const BenefitListPage({super.key});

  @override
  State<BenefitListPage> createState() => _BenefitListPageState();
}

class _BenefitListPageState extends State<BenefitListPage> {
  List dataList = [];

  @override
  void initState() {
    super.initState();
    // Pertama kali page dibuka langsung manggil ini
    _getListData();
  }

  void _getListData() async {
    // Url dari Postman
    Uri uri =
        Uri.parse('https://dancare-staging.saharsa-tech.com/api/why-dancare');

    /// Cara penggunaan package http
    var response = await http.get(uri);
    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

    /// Memasukkan data dari API ke variable dataList
    setState(() {
      dataList = List<Map<String, dynamic>>.from(jsonResponse['data']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final item = dataList[index];
          return ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                BenefitDetailPage.route,
                arguments: item['id'],
              );
            },
            leading: Image.network(
              item['image'],
              height: 300,
              width: 100,
              fit: BoxFit.fitWidth,
            ),
            title: Text(item['title']),
            subtitle: Text(
              item['content'],
              maxLines: 2,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12);
        },
      ),
    );
  }
}
