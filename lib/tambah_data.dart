import 'dart:convert';
import 'dart:io';
import 'package:pengelola_kelompok/list_data.dart';
import 'package:pengelola_kelompok/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahData extends StatefulWidget {
  const TambahData({super.key});
  @override
  State<TambahData> createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final namaController = TextEditingController();
  final tugasController = TextEditingController();

  Future postData(String nama, String tugas) async {
    String url = Platform.isAndroid
        ? 'http://192.168.201.184/kelompok_uts/index.php'
        : 'http://localhost/kelompok_uts/index.php';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody = '{"nama": "$nama", "tugas": "$tugas"}';
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

  _buatInput(control, String hint) {
    return TextField(
      controller: control,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Anggota'),
      ),
      drawer: const SideMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buatInput(namaController, 'Masukkan Nama Anggota'),
          _buatInput(tugasController, 'Masukkan Tugas Anggota'),
          ElevatedButton(
            child: const Text('Tambah Anggota'),
            onPressed: () {
              String? nama = namaController.text;
              String? tugas = tugasController.text;

              postData(nama, tugas).then((result) {
                if (result['pesan'] == 'berhasil') {
                  showDialog(
                      context: context,
                      builder: (context) {
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
    );
  }
}
