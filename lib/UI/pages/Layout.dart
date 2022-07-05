import 'package:frontend_ticketstore/UI/pages/Search.dart';
import 'package:flutter/material.dart';

import '../../model/support/LogInResult.dart';
import '../../model/support/LoginState.dart';
import 'ListaBiglietti.dart';
import 'Login.dart';

//verifica correttezza todo
class Layout extends StatefulWidget {
  final String title;

  Layout({Key? key,required this.title}) : super(key: key);

  //static _LayoutState layout = _LayoutState();
  @override
  _LayoutState createState() => _LayoutState();

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
        floatingActionButton: FloatingActionButton(
          child: Column(
            children: const [Icon(Icons.logout), Text("logout")],
          ),
          onPressed: (){LoginState.sharedInstance.setLoginState(LogInResult.error_wrong_credentials);},
        ),
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
            getChild(),
            Search(),
          ],
        ),
      ),
    );
  }

  StatefulWidget getChild(){
    return LoginState.sharedInstance.getLoginState() != LogInResult.logged?
    Login()
        : ListaBiglietti();
  }

}
