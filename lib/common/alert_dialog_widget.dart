import 'dart:ui';
import 'package:flutter/material.dart';


class CustomAlertDialog extends StatelessWidget {

  String title;
  String content;
  VoidCallback continueCallBack;

  CustomAlertDialog(this.title, this.content, this.continueCallBack);
  TextStyle textStyle = TextStyle (color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  AlertDialog(
          title: new Text(title,style: textStyle,),
          content: new Text(content, style: textStyle,),
          actions: <Widget>[
            new FlatButton(
              child: new Text("SIM"),
              onPressed: () {
                continueCallBack();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: Text("CANCELAR"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}