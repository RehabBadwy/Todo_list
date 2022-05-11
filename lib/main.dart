import 'package:add_todo_list/edit/edit_screen.dart';
import 'package:add_todo_list/my_theme_data.dart';
import 'package:add_todo_list/provider/app_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home/home_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (_)=>AppConfigProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  late AppConfigProvider provider;
  late SharedPreferences pref;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     provider = Provider.of<AppConfigProvider>(context);
     initShared();
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('ar', ''), // Spanish, no country code
      ],
      locale:Locale(provider.appLanguage, '') ,
      theme: ThemeData(
          primaryColor:MyThemeData.primaryColor,
          scaffoldBackgroundColor: MyThemeData.colorAccent,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: MyThemeData.primaryColor,
          )
      ),
      routes: {
        HomeScreen.ROUTE_NAME : (context)=>HomeScreen(),
        EditScreen.routeName: (context)=>EditScreen(),
      },
      initialRoute: HomeScreen.ROUTE_NAME,
    );
  }
  void initShared()async{
     pref = await SharedPreferences.getInstance();
     provider.setNewLanguage(pref.getString('language')??'en');
     if(pref.getString('theme')=='light'){
       provider.setNewTheme(ThemeMode.light);
     }else if(pref.getString('theme')=='dark'){
       provider.setNewTheme(ThemeMode.dark);
     }
  }
}


