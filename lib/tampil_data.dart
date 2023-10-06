// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:uts/list_data.dart';
import 'package:uts/side_menu.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class DetailPekerjaan extends StatefulWidget {
  final dynamic id;
  const DetailPekerjaan({super.key, this.id});

  @override
  State<DetailPekerjaan> createState() => _DetailPekerjaanState();
}

class _DetailPekerjaanState extends State<DetailPekerjaan> {
  Map<String, dynamic> dataPekerjaan= {};
  String url = Platform.isAndroid
      ? 'http://10.0.2.2/uts/index.php'
      : 'http://localhost/uts/index.php';

  Future<dynamic> getData(dynamic id) async {
    final response = await http.get(Uri.parse("$url?id=$id"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        dataPekerjaan= {"pekerjaan": data['pekerjaan'], "status": data['status']};
      });
    } else {
      return null;
    }
  }

  @override
  void initState() {
    getData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Detail Data Pekerjaan"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:MainAxisAlignment.start ,
            children: [
              Text("pekerjaan : ${dataPekerjaan['pekerjaan']} "),
            ],
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.start ,
            children: [
              Text("status : ${dataPekerjaan['status']}"),
            ],
          ),
          ElevatedButton(
          onPressed:(){
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (context) => ListData(),
              ),
            );
          } , child: Text("Kembali")
          ),
        ],
      )
      )
      ,
    );
  }
}
