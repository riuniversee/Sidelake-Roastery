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
    return [
      CoffeeBean(
        id: '1',
        name: 'Wanagiri Arabica Specialty',
        origin: 'Wanagiri, Buleleng, Bali',
        process: 'Full Wash',
        roastLevel: 'Medium Roast',
        flavorNotes: 'Brown Sugar, Green Apple, Citrus',
        price: 95000,
        imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500',
      ),
      CoffeeBean(
        id: '2',
        name: 'Munduk Robusta Kopyol',
        origin: 'Munduk, Buleleng, Bali',
        process: 'Natural Process',
        roastLevel: 'Dark Roast',
        flavorNotes: 'Dark Chocolate, Nutty, Heavy Body',
        price: 75000,
        imageUrl: 'https://images.unsplash.com/photo-1587734195503-904fca47e0e9?w=500',
      ),
      CoffeeBean(
        id: '3',
        name: 'Pupuan Arabica Kartika',
        origin: 'Pupuan, Tabanan, Bali',
        process: 'Honey Process',
        roastLevel: 'Light to Medium Roast',
        flavorNotes: 'Floral, Honey, Peach, Jasmine',
        price: 110000,
        imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=500',
      ),
    ];
  }
}