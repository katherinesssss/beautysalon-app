import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:beautysalon/components/databasehelper';
import 'package:beautysalon/components/user_provider.dart';
import 'package:beautysalon/pages/cart_page.dart';
import 'package:beautysalon/pages/main_page.dart';
import 'package:beautysalon/pages/service_page.dart';
import 'package:beautysalon/pages/settings_page.dart';
import 'package:beautysalon/pages/sign_in_page.dart';
import 'package:beautysalon/pages/sign_up_page.dart';
import 'package:beautysalon/provider/cart_provider.dart';
import 'package:beautysalon/provider/theme_provider.dart';
import 'package:beautysalon/provider/booking_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Достаточно одного вызова
  
  // Инициализация базы данных
  try {
    await DatabaseHelper().database; // Инициализация через getter
    debugPrint('Database initialized successfully');
  } catch (e) {
    debugPrint('Database initialization error: $e');
  }

  // Тестовые данные (можно удалить после проверки)
  try {
    final userProvider = UserProvider();
    final email = 'test${DateTime.now().millisecond}@test.com';
    
    final signUpSuccess = await userProvider.signUp(email, '123');
    debugPrint('Sign up success: $signUpSuccess');
    
    final signInSuccess = await userProvider.signIn(email, '123');
    debugPrint('Sign in success: $signInSuccess');
  } catch (e) {
    debugPrint('Test auth error: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/signup': (context) => const SignUpPage(),
            '/home': (context) => const MainPage(),
            '/signin': (context) => const SignInPage(),
            '/settings': (context) => const SettingsPage(),
            '/services': (context) => const ServicePage(),
            '/cart': (context) => const CartPage(),
            '/logout':(context)=> const SignInPage(),
          },
          theme: themeProvider.themeMode,
          home: const SplashScreen(), // Лучше использовать либо initialRoute, либо home
        );
      },
    );
  }
}
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('lib/assets/splash-screen.json'),
      nextScreen: const SignInPage(),
      splashTransition: SplashTransition.slideTransition,
      duration:9000  ,
    );
  }
}