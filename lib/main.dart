import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news/blocs/auth/login/login_bloc.dart';
import 'package:news/blocs/auth/register/register_bloc.dart';
import 'package:news/blocs/home/news/news_bloc.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/network/auth/login/login_api_service.dart';
import 'package:news/network/auth/register/register_api_service.dart';
import 'package:news/network/news/news_api_serice.dart';
import 'package:news/screens/auth/login/login_screen.dart';
import 'package:news/screens/auth/register/register_screen.dart';
import 'package:news/screens/home/home_screen.dart';
import 'package:news/src/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  await dotenv.load(fileName:".env");
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final String? token = await storage.read(key: "jwt");
  runApp(MyApp(isLoggedIn: token != null));
}


class MyApp extends StatelessWidget {
    final bool isLoggedIn;
  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterBloc(RegisterApiService()),
        child: RegisterScreen(),),
        BlocProvider(create: (context) => LoginBloc(LoginApiService()),
        child: LoginScreen(),
        ),
         BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(NewsApiService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.newsTitle,
        theme: ThemeData(primarySwatch: Colors.blue),
         supportedLocales: [
        Locale('en', ''),  
        Locale('hr', ''),  
      ],
      localizationsDelegates: [
        AppLocalizations.delegate, 
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;},
        home: isLoggedIn ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}
