import 'package:flutter/material.dart';
import 'package:mcd_bot/modules/home/ui/page/home_bottom_navigator.dart';
import 'package:mcd_bot/theme/theme.dart';
import 'package:mcd_bot/util/providers/app_providers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders().providers,
      child: MaterialApp(
        title: 'Mcd Bots',
        theme: AppTheme.defaultTheme,
        home: const HomeBottomNavigator(),
      ),
    );
  }
}
