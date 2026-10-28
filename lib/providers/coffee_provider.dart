import 'package:flutter/material.dart';
import '../models/coffee_bean.dart';
import '../repositories/coffee_repository.dart';

enum StateStatus { initial, loading, loaded, error }

class CoffeeProvider with ChangeNotifier {
  final CoffeeRepository repository;
  CoffeeProvider({required this.repository});

  List<CoffeeBean> _beans = [];
  List<CoffeeBean> _filteredBeans = [];
  StateStatus _status = StateStatus.initial;
  String _errorMessage = '';
  String _selectedCategory = 'All';

  List<CoffeeBean> get beans => _filteredBeans;
  StateStatus get status => _status;
  String get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;

  Future<void> loadCoffeeBeans() async {
    _status = StateStatus.loading;
    notifyListeners();

    try {
      _beans = await repository.getCoffeeBeans();
      _applyFilter();
      _status = StateStatus.loaded;
    } catch (e) {
      _errorMessage = 'Gagal memuat katalog kopi: ${e.toString()}';
      _status = StateStatus.error;
    }
    notifyListeners();
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    if (_selectedCategory == 'All') {
      _filteredBeans = List.from(_beans);
    } else {
      _filteredBeans = _beans
          .where((bean) =>
              bean.process.toLowerCase().contains(_selectedCategory.toLowerCase()) ||
              bean.roastLevel.toLowerCase().contains(_selectedCategory.toLowerCase()))
          .toList();
    }
  }
}