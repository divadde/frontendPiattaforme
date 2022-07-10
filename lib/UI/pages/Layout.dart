import 'package:frontend_ticketstore/UI/pages/Search.dart';
import 'package:flutter/material.dart';

import '../../model/Model.dart';
import '../../model/support/LogInResult.dart';
import '../../model/support/LoginState.dart';
import 'ListaBiglietti.dart';
import 'Login.dart';


//todo forse risolto
class Layout extends StatefulWidget {
  final String title;

  Layout({Key? key,required this.title}) : super(key: key);

  static _LayoutState layoutState = _LayoutState();
  @override
  State<StatefulWidget> createState() => layoutState;


  static void setLogState(String email){
    layoutState.email=email;
    layoutState.setState((){}); //setLogResult, preso come stringa
  }

}//Layout


class _LayoutState extends State<Layout> {
  String title = "TicketStore";
  String? email;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Column(
            children: const [Icon(Icons.logout), Text("logout")],
          ),
          onPressed: (){setState((){
            if(LoginState.sharedInstance.getLoginState()==LogInResult.logged) Model.sharedInstance.logOut();
            LoginState.sharedInstance.setLoginState(LogInResult.error_wrong_credentials);});},
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
    print("Stato del login globale: ");
    print(LoginState.sharedInstance.getLoginState());
    return LoginState.sharedInstance.getLoginState() != LogInResult.logged?
    Login() : ListaBiglietti(email:email!);
  }

}
