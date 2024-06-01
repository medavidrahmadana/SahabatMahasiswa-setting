import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_model.dart';
import 'feedback.dart';
import 'gantiBahasa.dart';
import 'gantiTema.dart';

class Setting extends StatelessWidget {
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
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: themeModel.isDarkMode ? Colors.white : Color(0xFF353535),
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
                SizedBox(height: 50),
                Text(
                  'Settings',
                  style: TextStyle(
                    color: themeModel.isDarkMode ? Colors.white : Color(0xFF353535),
                    fontSize: 40,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangeLanguage()),
                    );
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
                    'Change Language',
                    style: TextStyle(
                      color: themeModel.isDarkMode ? Color(0xFF353535) : Colors.white,
                      fontSize: 20,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangeTheme()),
                    );
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
                    'Change Theme',
                    style: TextStyle(
                      color: themeModel.isDarkMode ? Color(0xFF353535) : Colors.white,
                      fontSize: 20,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()),
                    );
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
                    'Feedback',
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
