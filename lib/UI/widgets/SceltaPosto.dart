import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SceltaPosto extends StatefulWidget {

  SceltaPosto({Key? key}) : super(key: key);

  _SceltaState sceltaPosto = _SceltaState();

  @override
  State<SceltaPosto> createState() => sceltaPosto;

  String? getValue(){
    return sceltaPosto.getValue();
  }

}

class _SceltaState extends State<SceltaPosto> {
  String? valore;

  @override
  Widget build(BuildContext context) {
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
      items: <String>['1', '2', '3', '4', '5']
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