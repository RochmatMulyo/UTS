// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:uts/list_data.dart';
import 'package:uts/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {
  final dynamic id;
  const EditData({Key? key, required this.id}) : super(key: key);

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final pekerjaanController = TextEditingController();
  final statusController = TextEditingController();

  String url = Platform.isAndroid
      ? 'http://10.0.2.2/uts/index.php'
      : 'http://localhost/uts/index.php';

  Future<dynamic> updateData(String id, String pekerjaan, String status) async {
    // print("updating");
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody = '{"id":$id,"pekerjaan": "$pekerjaan", "status": "$status"}';
    var response = await http.put(Uri.parse("$url?id=$id"),
        headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add data');
    }
  }

  Future<dynamic> getData(dynamic id) async {
    final response = await http.get(Uri.parse("$url?id=$id"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        pekerjaanController.text = data['pekerjaan'];
        statusController.text = data['status'];
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
      appBar: AppBar(
        title: const Text('Edit Data Pekerjaan'),
      ),
      drawer: const SideMenu(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: pekerjaanController,
              decoration: const InputDecoration(
                hintText: 'Nama Pekerjaan',
              ),
            ),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(
                hintText: 'status',
              ),
            ),
            ElevatedButton(
              child: const Text('Edit Pekerjaan'),
              onPressed: () {
                String pekerjaan = pekerjaanController.text;
                String status = statusController.text;

                // updateData(widget.id,pekerjaan, status);

                updateData(widget.id, pekerjaan, status).then((result) {
                  print(result);
                  if (result['pesan'] == 'berhasil') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Data berhasil di ubah'),
                            content: const Text('ok'),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ListData(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        });
                  }
                });
              },
            ),
          ],
        ),

        //     ],
        //   ),
        // ),
      ),
    );
  }
}
