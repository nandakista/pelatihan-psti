import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BenefitDetailPage extends StatefulWidget {
  static const route = '/detail';

  const BenefitDetailPage({super.key, required this.id});

  final int id;

  @override
  State<BenefitDetailPage> createState() => _BenefitDetailPageState();
}

class _BenefitDetailPageState extends State<BenefitDetailPage> {
  Map dataItem = {};

  @override
  void initState() {
    super.initState();
    getDataObject();
  }

  void getDataObject() async {
    // Url dari Postman
    Uri uri = Uri.parse(
        'https://dancare-staging.saharsa-tech.com/api/why-dancare/${widget.id}');

    /// Cara penggunaan package http
    var response = await http.get(uri);
    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

    print('response ${jsonResponse}');

    /// Memasukkan data dari API ke variable dataList
    setState(() {
      dataItem = jsonResponse['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${dataItem['title']}'),
      ),
      body: dataItem.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    '${dataItem['image']}',
                    fit: BoxFit.cover,
                    width: MediaQuery.sizeOf(context).width,
                    height: 200,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '${dataItem['content']}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
