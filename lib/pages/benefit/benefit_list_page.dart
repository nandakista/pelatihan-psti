import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pertemuan_2/pages/benefit/benefit_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:pertemuan_2/utility/api_constant.dart';

class BenefitListPage extends StatefulWidget {
  static const route = '/list';

  const BenefitListPage({super.key});

  @override
  State<BenefitListPage> createState() => _BenefitListPageState();
}

class _BenefitListPageState extends State<BenefitListPage> {
  List dataList = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _getListData();
  }

  void _getListData() async {
    try {
      Uri uri = Uri.parse('${ApiConstant.baseUrl}/why-dancares');
      var response = await http.get(uri);
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        setState(() {
          dataList = List<Map<String, dynamic>>.from(jsonResponse['data']);
          errorMessage = '';
        });
      } else {
        setState(() {
          errorMessage = jsonResponse['message'];
        });
      }
    } on SocketException {
      setState(() {
        errorMessage = 'Pastikan koneksi internet anda stabil';
      });
    } catch (error, stackTrace) {
      debugPrint('error : $error, $stackTrace');
      setState(() {
        errorMessage = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (dataList.isNotEmpty) {
      return ListView.separated(
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
      );
    } else if (errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://cdn0.iconfinder.com/data/icons/shift-interfaces/32/Error-512.png',
              height: 80,
              width: 80,
            ),
            const SizedBox(height: 20),
            Text(
              'Oops, $errorMessage',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
