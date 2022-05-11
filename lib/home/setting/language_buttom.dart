import 'package:add_todo_list/provider/app_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {


  @override
  _LanguageBottomSheetState createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    AppConfigProvider provider=Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
            onTap: (){
              provider.setNewLanguage('ar');
            },
            child: getItemDesign('العربيه',provider.appLanguage=='ar')),
        InkWell(
            onTap: (){
              provider.setNewLanguage('en');
            },
            child: getItemDesign('English',provider.appLanguage=='en')),
      ],
    );
  }
  Widget getItemDesign(String language,bool selected){
    if(selected){
      return    Container(
          margin: EdgeInsets.all(18),
          //padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Text(language,textAlign: TextAlign.start,style:TextStyle(color: Theme.of(context).primaryColor ),),
              Spacer(),
              Icon(Icons.check,color: Theme.of(context).primaryColor,)
            ],
          ));
    }else {
      return Container(
          margin: EdgeInsets.all(18),
          //padding: EdgeInsets.all(),
          child: Text(language,textAlign: TextAlign.start,));
    }
  }
}