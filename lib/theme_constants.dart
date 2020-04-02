import 'package:flutter/material.dart';

enum themeElement {
  backgroundFrom,
  backgroundTo,
  cardColor,
  text,
  shadow,
}

final _lightTheme = {
  themeElement.backgroundFrom: Colors.black, //Color.fromRGBO(17, 23, 21, 1.0),
  themeElement.backgroundTo: Color.fromARGB(255, 100, 95, 91),
  themeElement.cardColor: Color.fromARGB(180, 26, 82, 118),
  themeElement.text: Colors.white,

};

final _darkTheme = {
  themeElement.backgroundFrom: Color.fromARGB(255, 100, 95, 91),
  themeElement.backgroundTo: Color.fromARGB(255, 8, 8, 8 ),
  themeElement.cardColor: Color.fromARGB(180, 26, 82, 118),
  themeElement.text: Colors.white,
};

Map getLightTheme()
{return _lightTheme;}

Map getDarkTheme()
{return _darkTheme;}
