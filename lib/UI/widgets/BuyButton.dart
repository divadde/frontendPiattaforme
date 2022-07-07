import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyButton extends StatelessWidget {
  final Function() onPressed;

  const BuyButton({Key? key, required this.onPressed}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: RawMaterialButton(
        onPressed: onPressed,
        elevation: 2.0,
        fillColor: Theme.of(context).primaryColor,
        child: Text("Acquista", textScaleFactor: 1, style: TextStyle(color: Theme.of(context).backgroundColor)),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      )
    );
  }


}