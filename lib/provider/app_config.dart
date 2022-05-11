import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier{

  String appLanguage='en';
  ThemeMode themeMode=ThemeMode.light;

  void setNewLanguage(String newLang)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(appLanguage== newLang) return ;
    appLanguage=newLang;
    pref.setString('language', newLang);
    notifyListeners();
  }

  void setNewTheme(ThemeMode mode)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(themeMode== mode) return ;
    themeMode=mode;
    pref.setString('them', mode==ThemeMode.light?'light':'dark');
    notifyListeners();
  }
}