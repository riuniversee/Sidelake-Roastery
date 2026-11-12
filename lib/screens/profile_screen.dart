import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/providers/auth_provider.dart'; // Sesuaikan path jika perlu
import 'login_screen.dart';     // Sesuaikan path jika perlu

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil email user yang sedang login dari Supabase
    final userEmail = Supabase.instance.client.auth.currentUser?.email ?? 'Tidak diketahui';

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
            const SizedBox(height: 4),
            const Text(
              'NIM: 2455011011',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sidelake Roastery - Barista & Developer',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            const Divider(height: 40),
            ListTile(
              leading: const Icon(Icons.email, color: Color(0xFF3E2723)),
              title: const Text('Akun Login'),
              subtitle: Text(userEmail),
            ),
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
            const Spacer(),
            // Tombol Logout
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  // Proses Keluar Akun
                  await Supabase.instance.client.auth.signOut();
                  if (!context.mounted) return;
                  
                  // Kembali ke halaman Login dan hapus riwayat navigasi sebelumnya
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout / Keluar', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}