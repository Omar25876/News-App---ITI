// main.dart
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/core/service_locator.dart';
import 'package:news_app/core/theme/light.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/features/profile/app_controller.dart';
import 'package:news_app/features/search/article_details_screen.dart';
import 'package:news_app/features/splash/splash_screen.dart';
import 'package:news_app/features/main/main_screen.dart';
import 'package:news_app/features/onboarding/onboarding_screen.dart';
import 'package:news_app/features/auth/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/preferences_manager.dart';
import 'features/categories/categories_screen.dart';
import 'features/home/controller/home_controller.dart';
import 'features/profile/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager().init();

  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();

  Hive.registerAdapter(NewsArticleAdapter());

  await Hive.openBox('bookmarks');
  await Hive.openBox('settings');

  setupLocator();

  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
       ChangeNotifierProvider(create: (_) => UserController()..loadUserData(),),


      ],
      child: MaterialApp(
        supportedLocales: [
          const Locale('en'),
          const Locale('ar'),
          const Locale.fromSubtags(languageCode: 'ar', scriptCode: 'arabic'),
          const Locale.fromSubtags(languageCode: 'ar', scriptCode: 'arabic'),
        ],
        localizationsDelegates: [
          CountryLocalizations.delegate,
        ],
        theme: AppTheme.lightTheme,
        home: const SplashScreenWrapper(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/main': (_) => const MainScreen(),
          '/onboarding': (_) => const OnboardingScreen(),
          '/signin': (_) => const SignInScreen(),
          '/searchDetails': (_) => const ArticleDetailsScreen(),
          '/categories': (_) => const CategoriesScreen(),
        },
      ),
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    if (!mounted) return;
    if (!onboardingComplete) {
      Navigator.of(context).pushReplacementNamed('/onboarding');
    } else if (!isLoggedIn) {
      Navigator.of(context).pushReplacementNamed('/signin');
    } else {
      Navigator.of(context).pushReplacementNamed('/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
