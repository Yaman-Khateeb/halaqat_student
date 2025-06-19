

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:himmah_tracker/screens/select_campaign.dart';

import 'package:himmah_tracker/screens/home_screen.dart';
import 'package:himmah_tracker/screens/login_screen.dart';
import 'package:himmah_tracker/screens/qr_screen.dart';
import 'package:himmah_tracker/screens/quiz_screen.dart';
import 'package:himmah_tracker/screens/select_group_screen.dart';
import 'package:himmah_tracker/screens/tasks_screen.dart';
import 'package:intl/date_symbol_data_file.dart';

import 'dart:async'; // Add for timeout handling
import 'package:flutter/services.dart'; // Add for error handling




final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 40, 146, 155),
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  textTheme: GoogleFonts.tajawalTextTheme().copyWith(
    headlineLarge: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    titleMedium: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    bodyLarge: const TextStyle(fontSize: 18),
    bodyMedium: const TextStyle(fontSize: 16),
    labelSmall: const TextStyle(fontSize: 12, color: Colors.grey),
  ),
  scaffoldBackgroundColor: const Color(0xFFE5F3F5),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFE5F3F5),
    elevation: 0,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);



void main() async {
  // Error handling wrapper
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    // Initialize critical components with timeout
    await _initializeApp();
    
    runApp(
      ProviderScope(
        child: MaterialApp(
          theme: theme,
          routes: {
            '/login': (context) =>  LoginPage(),
            '/qr': (context) => const QrCodePage(),
            '/home': (context) => const HomeScreen(),
            '/tasks': (context) => const TasksScreen(),
            '/quiz': (context) => const QuizScreen(),
            '/campaigns': (context)=> const SelectCampaignScreen(),
            
          },
          home:  LoginPage(),
          // Add error screen for initialization failures
          builder: (context, child) => child!,
        ),
      ),
    );
  }, (error, stack) {
    // Handle initialization errors
    print('APP INIT ERROR: $error\n$stack');
    SystemNavigator.pop(); // Exit app on critical errors
  });
}

Future<void> _initializeApp() async {
  try {
    // Timeout to prevent eternal hanging
    await dotenv.load(fileName: ".env")
        .timeout(const Duration(seconds: 5));
    
    // Add other async initializations here if needed
    
  } on TimeoutException catch (_) {
    throw Exception('Environment load timed out. Check .env configuration');
  } catch (e) {
    throw Exception('Failed to initialize app: $e');
  }
}