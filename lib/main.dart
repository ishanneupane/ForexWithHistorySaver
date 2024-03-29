import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hh/app/controller/dependency_injection.dart';
import 'package:provider/provider.dart';

import 'src/calculator/provider/forex_calculator_provider.dart';
import 'src/forex/dbhelper/forex_api_state.dart';
import 'src/splash/spashscreen_ui.dart';
import 'src/splash/splash_state.dart';

void main() {
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashState()),
        ChangeNotifierProvider(create: (_) => ForexCalculatorState()),
        ChangeNotifierProvider(create: (_) => CurrencyRateProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.cyan,
            primaryColor: Colors.cyanAccent,
            iconTheme: const IconThemeData(color: Colors.white),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                fixedSize: const Size(double.infinity, 40),
              ),
            )),
        home: const SplashScreen(),
      ),
    );
  }
}
