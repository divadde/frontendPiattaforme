import 'package:frontend_ticketstore/UI/pages/Layout.dart';
import 'package:frontend_ticketstore/model/support/Constants.dart';
import 'package:flutter/material.dart';

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
