import 'package:flutter/material.dart';
import '../models/brew_log.dart';
import '../repositories/brew_log_repository.dart';
import 'coffee_provider.dart';

class BrewLogProvider with ChangeNotifier {
  final BrewLogRepository repository;
  BrewLogProvider({required this.repository});

  List<BrewLog> _logs = [];
  StateStatus _status = StateStatus.initial;
  String _errorMessage = '';

  List<BrewLog> get logs => _logs;
  StateStatus get status => _status;
  String get errorMessage => _errorMessage;

  Future<void> fetchBrewLogs() async {
    _status = StateStatus.loading;
    notifyListeners();

    try {
      _logs = await repository.fetchLogs();
      _status = StateStatus.loaded;
    } catch (e) {
      _errorMessage = 'Gagal mengambil catatan seduh: ${e.toString()}';
      _status = StateStatus.error;
    }
    notifyListeners();
  }

  Future<bool> addLog(BrewLog log) async {
    try {
      await repository.createLog(log);
      await fetchBrewLogs();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal menyimpan catatan: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateLog(BrewLog log) async {
    try {
      await repository.editLog(log);
      await fetchBrewLogs();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal memperbarui catatan: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteLog(int id) async {
    try {
      await repository.removeLog(id);
      await fetchBrewLogs();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal menghapus catatan: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }
}