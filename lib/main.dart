import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'database/isar_service.dart';

// Providers packages 
import 'package:provider/provider.dart';
import 'providers/category_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => CategoryProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Document Manager',
      debugShowCheckedModeBanner: false,
      theme:  AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
