import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_model.dart';
import 'setting.dart';

class ChangeTheme extends StatefulWidget {
  @override
  _ChangeThemeState createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context);
    return MaterialApp(
      theme: themeModel.currentTheme,
      home: Scaffold(
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
                    'Change Theme',
                    style: TextStyle(
                      color: themeModel.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 40,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20),
                  SwitchButton(),
                  SizedBox(height: 10),
                  Text(
                    '*Switch to change theme',
                    style: TextStyle(
                      color: themeModel.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 15,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SwitchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 370,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
            image: DecorationImage(
              image: AssetImage('assets/img/SwitchButton.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 20), 
        Transform.scale(
          scale: 1.5,
          child: Switch(
            thumbIcon: thumbIcon,
            value: themeModel.isDarkMode,
            onChanged: (bool value) {
              themeModel.toggleTheme();
            },
          ),
        ),
      ],
    );
  }
}

final MaterialStateProperty<Icon?> thumbIcon =
    MaterialStateProperty.resolveWith<Icon?>(
  (Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(Icons.check);
    }
    return const Icon(Icons.close);
  },
);
