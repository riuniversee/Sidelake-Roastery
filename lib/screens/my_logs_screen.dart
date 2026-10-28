import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/brew_log_provider.dart';
import 'add_edit_brew_log_screen.dart';

class MyLogsScreen extends StatelessWidget {
  const MyLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logProvider = Provider.of<BrewLogProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jurnal Seduh Pribadi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddEditBrewLogScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: logProvider.status == StateStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : logProvider.logs.isEmpty
              ? const Center(
                  child: Text(
                      'Belum ada catatan seduh.\nKetuk tombol + untuk menambah!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: logProvider.logs.length,
                  itemBuilder: (context, index) {
                    final log = logProvider.logs[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(log.beanName,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            'Metode: ${log.brewMethod} • Rating: ${log.rating}⭐\nCatatan: ${log.personalNote}'),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        AddEditBrewLogScreen(existingLog: log),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final confirm = await showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Hapus Catatan?'),
                                    content: const Text(
                                        'Apakah Anda yakin ingin menghapus jurnal seduh ini?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(ctx, false),
                                          child: const Text('Batal')),
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(ctx, true),
                                          child: const Text('Hapus',
                                              style:
                                                  TextStyle(color: Colors.red))),
                                    ],
                                  ),
                                );
                                if (confirm == true && log.id != null) {
                                  await logProvider.deleteLog(log.id!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Catatan berhasil dihapus')),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3E2723),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEditBrewLogScreen(),
            ),
          );
        },
      ),
    );
  }
}