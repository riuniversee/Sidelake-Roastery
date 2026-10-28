import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengembang')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF3E2723),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kadek Ripa Adi Putra',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'NIM: 2415091000',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Teknologi Rekayasa Perangkat Lunak (TRPL)\nUniversitas Pendidikan Ganesha (Undiksha)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const Divider(height: 40),
            ListTile(
              leading: const Icon(Icons.coffee_maker, color: Color(0xFF3E2723)),
              title: const Text('Aplikasi'),
              subtitle: const Text('Sidelake Roastery v1.0.0'),
            ),
            ListTile(
              leading: const Icon(Icons.code, color: Color(0xFF3E2723)),
              title: const Text('Repository GitHub'),
              subtitle: const Text('github.com/riuniversee/Sidelake-Roastery'),
            ),
          ],
        ),
      ),
    );
  }
}