import '../models/brew_log.dart';
import '../services/supabase_service.dart';

class BrewLogRepository {
  final SupabaseService supabaseService;
  BrewLogRepository({required this.supabaseService});

  Future<List<BrewLog>> fetchLogs() => supabaseService.getBrewLogs();
  Future<void> createLog(BrewLog log) => supabaseService.addBrewLog(log);
  Future<void> editLog(BrewLog log) => supabaseService.updateBrewLog(log);
  Future<void> removeLog(int id) => supabaseService.deleteBrewLog(id);
}