import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'services/api_service.dart';
import 'services/supabase_service.dart';
import 'repositories/coffee_repository.dart';
import 'repositories/brew_log_repository.dart';
import 'providers/coffee_provider.dart';
import 'providers/brew_log_provider.dart';
import 'screens/main_navigation_screen.dart';

void main() async {
  // 1. Pastikan binding flutter siap
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inisialisasi koneksi ke Supabase menggunakan URL kamu
  await Supabase.initialize(
    url: 'https://ksplulbfrwpmzhdefznq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtzcGx1bGJmcndwbXpoZGVmem5xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTMxODEzNTAsImV4cCI6MjEwODc1NzM1MH0.E3u4pxI3vD3g9wGcQmK3hS2EHlBSb1hCqLge2fb080Q',
  );

  runApp(const SidelakeRoasteryApp());
}

class SidelakeRoasteryApp extends StatelessWidget {
  const SidelakeRoasteryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CoffeeProvider(
            repository: CoffeeRepository(apiService: ApiService()),
          )..loadCoffeeBeans(),
        ),
        ChangeNotifierProvider(
          create: (_) => BrewLogProvider(
            repository: BrewLogRepository(supabaseService: SupabaseService()),
          )..fetchBrewLogs(),
        ),
      ],
      child: MaterialApp(
        title: 'Sidelake Roastery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          scaffoldBackgroundColor: const Color(0xFFF8F5F2),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF3E2723),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        home: const MainNavigationScreen(),
      ),
    );
  }
}