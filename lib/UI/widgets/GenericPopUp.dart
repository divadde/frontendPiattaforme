
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenericPopUp extends StatelessWidget{
  String? label;

  GenericPopUp({Key? key, this.label});

  Widget build(BuildContext context) {
    return new AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         new Text(label!)
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Chiudi'),
        ),
      ],
    );
  }

}