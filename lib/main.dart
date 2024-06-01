import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'theme_model.dart';
import 'setting.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModel()..loadTheme(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void _loadLocaleAndTheme() async {
  await Provider.of<ThemeModel>(context, listen: false).loadTheme();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? localeCode = prefs.getString('locale');
  setState(() {
    _locale = localeCode != null ? Locale(localeCode) : Locale('en');
  });
}

@override
void initState() {
  super.initState();
  _loadLocaleAndTheme();
}

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, themeModel, child) {
        return MaterialApp(
          theme: themeModel.currentTheme,
          locale: _locale,
          supportedLocales: [
            Locale('en', ''),
            Locale('id', ''),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Setting(), // Sesuaikan dengan layar awal Anda
        );
      }
    );
  }
}