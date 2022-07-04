import 'package:frontend_ticketstore/UI/pages/Home.dart';
import 'package:frontend_ticketstore/UI/pages/Search.dart';
import 'package:flutter/material.dart';

import '../../model/support/LogInResult.dart';

//verifica correttezza todo
class Layout extends StatefulWidget {
  final String title;

  Layout({Key? key,required this.title}) : super(key: key);

  static _LayoutState layout = _LayoutState(); //todo NICK
  @override
  _LayoutState createState() => layout;

}//Layout


class _LayoutState extends State<Layout> {
  String title = "";

  _LayoutState() {
    this.title = title;
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Text(title),
          bottom: TabBar(
            tabs: [
              Tab(text: "Home", icon: Icon(Icons.home_rounded)),
              Tab(text: "Cerca eventi", icon: Icon(Icons.search_rounded)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Home(),
            Search(),
          ],
        ),
      ),
    );
  }

}
