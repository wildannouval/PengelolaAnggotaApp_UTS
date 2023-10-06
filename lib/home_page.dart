import 'package:pengelola_kelompok/side_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home - Pengelolaan Anggota App'),
      ),
      drawer: const SideMenu(),
      body: const Center(
          child:
              Text('Selamat Datang di Aplikasi Pengelolaan Anggota Kelompok')),
    );
  }
}
