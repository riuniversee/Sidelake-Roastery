import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/coffee_bean.dart';

class ApiService {
  final String baseUrl = 'https://raw.githubusercontent.com/riuniversee/Sidelake-Roastery/main/assets/data/beans.json';

  Future<List<CoffeeBean>> fetchCoffeeBeans() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => CoffeeBean.fromJson(json)).toList();
      } else {
        return _getFallbackBeans();
      }
    } catch (e) {
      return _getFallbackBeans();
    }
  }

  List<CoffeeBean> _getFallbackBeans() {
    // Menggunakan link gambar biji kopi yang terbukti sukses tampil di item pertama
    const String safeCoffeeImage = 'https://upload.wikimedia.org/wikipedia/commons/4/45/A_small_cup_of_coffee.jpg';

    return [
      // === KELOMPOK 1: FULL WASH (4 Katalog) ===
      CoffeeBean(
        id: '1',
        name: 'Wanagiri Arabica Specialty',
        origin: 'Wanagiri, Buleleng, Bali',
        process: 'Full Wash',
        roastLevel: 'Medium Roast',
        flavorNotes: 'Brown Sugar, Green Apple, Citrus',
        price: 95000,
        imageUrl: 'https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=500',
      ),
      CoffeeBean(
        id: '2',
        name: 'Bedugul Highland Wash',
        origin: 'Bedugul, Tabanan, Bali',
        process: 'Full Wash',
        roastLevel: 'Light to Medium Roast',
        flavorNotes: 'Floral, Lemonade, Crisp Acidity',
        price: 92000,
        imageUrl: 'https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=500',
      ),
      CoffeeBean(
        id: '3',
        name: 'Mandheling Classic Wash',
        origin: 'Sumatra Utara',
        process: 'Full Wash',
        roastLevel: 'Medium Roast',
        flavorNotes: 'Herbal, Earthy, Cedar, Dark Chocolate',
        price: 88000,
        imageUrl: 'https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=500',
      ),
      CoffeeBean(
        id: '4',
        name: 'Java Preanger Wash',
        origin: 'Java Barat',
        process: 'Full Wash',
        roastLevel: 'Medium Roast',
        flavorNotes: 'Caramel, Brown Spice, Balanced Body',
        price: 85000,
        imageUrl: 'https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=500',
      ),

      // === KELOMPOK 2: NATURAL PROCESS (4 Katalog) ===
      CoffeeBean(
        id: '5',
        name: 'Munduk Robusta Kopyol',
        origin: 'Munduk, Buleleng, Bali',
        process: 'Natural Process',
        roastLevel: 'Dark Roast',
        flavorNotes: 'Dark Chocolate, Nutty, Heavy Body',
        price: 75000,
        imageUrl: 'https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=500',
      ),
      CoffeeBean(
        id: '6',
        name: 'Kintamani Bali Natural',
        origin: 'Kintamani, Bangli, Bali',
        process: 'Natural Process',
        roastLevel: 'Medium Roast',
        flavorNotes: 'Tropical Fruit, Sweet Orange, Caramel',
        price: 98000,
        imageUrl: 'https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=500', // (Ganti dengan variabel aman di bawah jika perlu, atau pakai safeCoffeeImage)
      ),
      CoffeeBean(
        id: '7',
        name: 'Gayo Aceh Natural',
        origin: 'Takengon, Aceh',
        process: 'Natural Process',
        roastLevel: 'Medium to Dark Roast',
        flavorNotes: 'Ripe Berry, Winey, Chocolate Fudge',
        price: 105000,
        imageUrl: 'https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=500',
      ),
      CoffeeBean(
        id: '8',
        name: 'Flores Bajawa Natural',
        origin: 'Bajawa, Nusa Tenggara Timur',
        process: 'Natural Process',
        roastLevel: 'Dark Roast',
        flavorNotes: 'Tobacco, Dark Cocoa, Sweet Cherry',
        price: 99000,
        imageUrl: 'https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=500',
      ),

      // === KELOMPOK 3: HONEY PROCESS (4 Katalog) ===
      CoffeeBean(
        id: '9',
        name: 'Pupuan Arabica Kartika',
        origin: 'Pupuan, Tabanan, Bali',
        process: 'Honey Process',
        roastLevel: 'Light to Medium Roast',
        flavorNotes: 'Floral, Honey, Peach, Jasmine',
        price: 110000,
        imageUrl: 'https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=500',
      ),
      CoffeeBean(
        id: '10',
        name: 'Bali Yellow Honey',
        origin: 'Plaga, Badung, Bali',
        process: 'Honey Process',
        roastLevel: 'Medium Roast',
        flavorNotes: 'Melon, Cane Sugar, Smooth Butter',
        price: 102000,
        imageUrl: 'https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=500', // Link Unsplash aman via HTTPS
      ),
      CoffeeBean(
        id: '11',
        name: 'Java Black Honey',
        origin: 'Ijen, Jawa Timur',
        process: 'Honey Process',
        roastLevel: 'Medium Roast',
        flavorNotes: 'Black Cherry, Molasses, Plum',
        price: 115000,
        imageUrl: 'https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=500',
      ),
      CoffeeBean(
        id: '12',
        name: 'Kerinci Red Honey',
        origin: 'Jambi, Sumatra',
        process: 'Honey Process',
        roastLevel: 'Light Roast',
        flavorNotes: 'Red Apple, Cinnamon, Brown Sugar',
        price: 108000,
        imageUrl: 'https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=500',
      ),
    ];
  }
}