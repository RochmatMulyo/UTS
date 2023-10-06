// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';

import 'package:uts/splash.dart';
import 'package:flutter/material.dart';
import 'package:uts/tambah_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New App',
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController jurusanController = TextEditingController();

    get http => null;

    Future postData(String nama, String jurusan) async{
      String url = Platform.isAndroid 
      ? 'http://10.0.2.2/uts/index.php'
      : 'http://localhost/uts/index.php';

      Map<String, String> headers = {'Content-Type': 'Application/json' };
      String jsonBody = '{"nama":"$nama", "jurusan": "$jurusan"}';
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonBody,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add data');
    }
  }
    Future updateData (int id, String nama, String jurusan) async {
      final response = await http.put(
      Uri.parse('http://localhost/uts/index.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'id': id, 'nama': nama, 'jurusan': jurusan}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update data');
    }
    }
      @override
        Widget build(BuildContext context) {
        return Container();
  }
}