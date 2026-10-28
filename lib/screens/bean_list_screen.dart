import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/coffee_provider.dart';
import 'bean_detail_screen.dart';

class BeanListScreen extends StatelessWidget {
  const BeanListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final coffeeProvider = Provider.of<CoffeeProvider>(context);
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Biji Kopi Sidelake'),
      ),
      body: Column(
        children: [
          // Filter Kategori
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.white,
            child: Row(
              children: ['All', 'Wash', 'Natural', 'Honey'].map((category) {
                final isSelected = coffeeProvider.selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    selectedColor: const Color(0xFF3E2723),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                    onSelected: (_) {
                      coffeeProvider.filterByCategory(category);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: coffeeProvider.status == StateStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : coffeeProvider.beans.isEmpty
                    ? const Center(child: Text('Tidak ada kopi ditemukan.'))
                    : isWideScreen
                        ? GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: coffeeProvider.beans.length,
                            itemBuilder: (context, index) {
                              final bean = coffeeProvider.beans[index];
                              return _buildBeanCard(context, bean);
                            },
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: coffeeProvider.beans.length,
                            itemBuilder: (context, index) {
                              final bean = coffeeProvider.beans[index];
                              return _buildBeanCard(context, bean);
                            },
                          ),
          ),
        ],
      ),
    );
  }

  Widget _buildBeanCard(BuildContext context, dynamic bean) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BeanDetailScreen(bean: bean),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                bean.imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bean.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(bean.origin,
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 8),
                  Text('Flavor: ${bean.flavorNotes}',
                      style: const TextStyle(
                          fontSize: 12, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}