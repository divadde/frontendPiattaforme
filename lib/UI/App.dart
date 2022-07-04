import 'package:frontend_ticketstore/UI/pages/Layout.dart';
import 'package:frontend_ticketstore/model/support/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class App extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        backgroundColor: Colors.white,
      ),
      home: Layout(title: Constants.APP_NAME),
    );
  }

}
