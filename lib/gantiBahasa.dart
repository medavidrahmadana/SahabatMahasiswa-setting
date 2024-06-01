import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'theme_model.dart';
import 'setting.dart';
import 'main.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  Locale? _selectedLocale;

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  void _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localeCode = prefs.getString('locale');
    setState(() {
      _selectedLocale = localeCode != null ? Locale(localeCode) : Locale('en');
    });
  }

  void _saveLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);
    MyApp.setLocale(context, locale); // Apply the locale change globally
  }

  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: themeModel.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Text(
                  'Change Language',
                  style: TextStyle(
                    color: themeModel.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 40,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 250,
                  height: 150,
                  child: DropdownButtonFormField<Locale>(
                    value: _selectedLocale,
                    items: [
                      DropdownMenuItem<Locale>(
                        value: Locale('en'),
                        child: Text('English'),
                      ),
                      DropdownMenuItem<Locale>(
                        value: Locale('id'),
                        child: Text('Indonesia'),
                      ),
                    ],
                    onChanged: (Locale? selectedLocale) {
                      setState(() {
                        _selectedLocale = selectedLocale;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedLocale != null) {
                      _saveLocale(_selectedLocale!);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeModel.isDarkMode ? Colors.white : Color(0xFF353535),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    minimumSize: Size(250, 44),
                  ),
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      color: themeModel.isDarkMode ? Color(0xFF353535) : Colors.white,
                      fontSize: 20,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}