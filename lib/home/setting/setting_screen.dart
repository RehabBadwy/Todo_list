import 'package:add_todo_list/home/setting/language_buttom.dart';
import 'package:add_todo_list/home/setting/theme_buttom.dart';
import 'package:add_todo_list/provider/app_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatefulWidget {


  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider=Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: EdgeInsets.all(12),
            child: Text('langiage',
              // style:Theme.of(context).textTheme.headline1 ,
            )
        ),
        InkWell(
          onTap: (){
            showLanguageBottomSheet();
          },
          child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: Row(
              children: [
                Text(provider.appLanguage=='en'?'English':'العربيه'),
                Spacer(),
                Icon(Icons.arrow_downward_outlined)
              ],
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.all(12),
            child: Text('اللون',
              // style:Theme.of(context).textTheme.headline1 ,
            )
        ),
        InkWell(
          onTap: (){
            // showThemeBottomSheet();
          },
          child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: Row(
              children: [
                Text('light',
                // provider.themeMode==ThemeMode.light?
                // AppLocalizations.of(context)!.light:
                // AppLocalizations.of(context)!.dark
                ),
                Spacer(),
                Icon(Icons.arrow_downward_outlined)
              ],
            ),
          ),
        )
      ],
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(context: context, builder:(context){
      return LanguageBottomSheet();
    } );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(context: context, builder:(context){
      return ThemeBottomSheet();
    } );
  }

}
