import 'dart:convert';
// import 'dart:html';
import 'dart:io';

import 'package:uts/list_data.dart';
import 'package:uts/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahData extends StatefulWidget {
  const TambahData({Key? key}) : super(key: key);

  @override
  _TambahDataState createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final pekerjaanController = TextEditingController();
  final statusController = TextEditingController();

  Future postData (String pekerjaan, String status)async{
    String url = Platform.isAndroid
        ? 'http://10.0.2.2/uts/index.php'
        : 'http://localhost/uts/index.php';

        Map<String, String> headers = {'Content-type':'application/json'};
        String jsonBody = '{"pekerjaan":"$pekerjaan", "status": "$status"}';
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
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Pekerjaan'),
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
                hintText: 'nama Pekerjaan',
              ),
            ),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(
                hintText: 'status',
              ),
            ),
            ElevatedButton(
              child: const Text('Tambah Pekerjaan'),
              onPressed: () {
                String pekerjaan = pekerjaanController.text;
                String status = statusController.text;
                // print(pekerjaan);
                postData(pekerjaan, status).then((result) {
                  //print(result['pesan']);
                  if (result['pesan'] == 'berhasil') {
                    print("hello");
                    showDialog(
                        context: context,
                        builder: (context) {
                          //var pekerjaanuser2 = pekerjaanuser;
                          return AlertDialog(
                            title: const Text('Data berhasil di tambah'),
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
                  setState(() {});
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
