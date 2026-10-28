import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/brew_log.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<BrewLog>> getBrewLogs() async {
    final response = await _client
        .from('user_brew_logs')
        .select()
        .order('created_at', ascending: false);
    return (response as List).map((json) => BrewLog.fromJson(json)).toList();
  }

  Future<void> addBrewLog(BrewLog log) async {
    await _client.from('user_brew_logs').insert(log.toJson());
  }

  Future<void> updateBrewLog(BrewLog log) async {
    if (log.id == null) return;
    await _client.from('user_brew_logs').update(log.toJson()).eq('id', log.id!);
  }

  Future<void> deleteBrewLog(int id) async {
    await _client.from('user_brew_logs').delete().eq('id', id);
  }
}