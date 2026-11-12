import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  User? get currentUser => _supabase.auth.currentUser;

  // Fungsi Login
  Future<String?> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // Null artinya berhasil tanpa error
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Terjadi kesalahan saat login.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fungsi Register (Daftar Akun)
  Future<String?> register(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _supabase.auth.signUp(
        email: email.trim(),
        password: password.trim(),
      );
      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Terjadi kesalahan saat mendaftar.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fungsi Logout
  Future<void> logout() async {
    await _supabase.auth.signOut();
    notifyListeners();
  }
}