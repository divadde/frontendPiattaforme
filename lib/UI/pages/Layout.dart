import 'package:frontend_ticketstore/UI/pages/Home.dart';
import 'package:frontend_ticketstore/UI/pages/Search.dart';
import 'package:flutter/material.dart';

//OK
class Layout extends StatefulWidget {
  final String title;


  Layout({Key? key,required this.title}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState(title);

}//Layout


class _LayoutState extends State<Layout> {
  String title = "";

  _LayoutState(String title) {
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
              Tab(text: "Cerca", icon: Icon(Icons.search_rounded)),
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
