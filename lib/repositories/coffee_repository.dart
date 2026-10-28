import '../models/coffee_bean.dart';
import '../services/api_service.dart';

class CoffeeRepository {
  final ApiService apiService;
  CoffeeRepository({required this.apiService});

  Future<List<CoffeeBean>> getCoffeeBeans() => apiService.fetchCoffeeBeans();
}