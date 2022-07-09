import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SceltaSettore extends StatefulWidget {

  SceltaSettore({Key? key}) : super(key: key);

  static _SceltaState sceltaSettore = _SceltaState();
  @override
  State<SceltaSettore> createState() => sceltaSettore;

  String? getValue(){
    return sceltaSettore.getValue();
  }

}

class _SceltaState extends State<SceltaSettore> {
  String? valore;

  @override
  Widget build(BuildContext context) {
    print("settore: ");
    print(valore);
    return DropdownButton<String>(
      value: valore,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          valore = newValue!;
        });
      },
      items: <String>['Gradinata', 'Tribuna', 'Curva']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  String? getValue(){
    return valore;
  }

}