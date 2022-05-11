import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showMessage(
    String message,
    BuildContext context,
    VoidCallback okCallBack,
    String actionName,
    {
      String? negActionName,
      VoidCallback? negActionCallBack,
    })
{
  showDialog(
      context: context,
      builder: (buildContext){
        List<Widget> actions =[
          TextButton(
              onPressed: (){
                Navigator.pop(context);
                okCallBack();
              },
              child: Text(actionName)
          ),

        ];
        if(negActionName!=null){
          actions.add(TextButton(
            onPressed: (){
              Navigator.pop(context);
              if(negActionCallBack!=null)
                negActionCallBack();
            },
            child: Text(negActionName),
          ),
          );
        }
        return AlertDialog(
          content: Text(message),
          actions:actions,

        );
      });
}

void showLoading(BuildContext context,String message){
  showDialog(
      context: context,
      builder: (buildContext){
        return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 20,
                  ),
                  Text(message)
                ],
              ),
            )
        );
      }
  );
}

void hideLoadingDialog(BuildContext context){
  Navigator.pop(context);
}