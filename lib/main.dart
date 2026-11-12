import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'services/api_service.dart';
import 'services/supabase_service.dart';
import 'repositories/coffee_repository.dart';
import 'repositories/brew_log_repository.dart';
import 'providers/coffee_provider.dart';
import 'providers/brew_log_provider.dart';
import 'providers/auth_provider.dart'; // <-- Pastikan file ini sudah dibuat sebelumnya
import 'screens/main_navigation_screen.dart';
import 'screens/login_screen.dart';     // <-- Import halaman login kamu

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const SidelakeRoasteryApp());
}

class AppColors {
  static const Color primary = Color(0xFF4A2B20); // Cokelat Kopi Tua
  static const Color secondary = Color(0xFFC89B7B); // Warm Caramel
  static const Color background = Color(0xFFFDF8F5); // Cream Warm Background
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF2C1810);
  static const Color textMuted = Color(0xFF8D7B74);
}

class SidelakeRoasteryApp extends StatelessWidget {
  const SidelakeRoasteryApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengecek apakah user sudah memiliki sesi login aktif di Supabase
    final bool isLoggedin = Supabase.instance.client.auth.currentSession != null;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()), // <-- Ditambahkan di sini
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
        // Jika belum login, buka LoginScreen. Jika sudah, buka MainNavigationScreen.
        home: isLoggedin ? const MainNavigationScreen() : const LoginScreen(),
      ),
    );
  }
}