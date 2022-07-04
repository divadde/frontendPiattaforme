import 'package:flutter/material.dart';

import '../../model/support/LogInResult.dart';
import 'package:frontend_ticketstore/UI/pages/Login.dart';
import 'package:frontend_ticketstore/UI/pages/ListaBiglietti.dart';

import '../../model/support/LoginState.dart';

//verifica correttezza //todo
class Home extends StatefulWidget {

  Home({Key? key}) : super(key: key);

  static _HomeState home = _HomeState(); //todo NICK

  @override
  _HomeState createState() => home;

  /*
  static void setLogState(LogInResult l){ //todo NICK
    home.setLogResult(l);
  }
   */

}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text( "Benvenuto su TicketStore!",
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: getChild()
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Scaffold( //todo NICK
                floatingActionButton: FloatingActionButton(
                  child: Column(
                    children: const [Icon(Icons.logout), Text("logout")],
                  ),
                  onPressed: (){LoginState.sharedInstance.setLoginState(LogInResult.error_wrong_credentials);},
                ),
              ),
            )
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

  /*
  void setLogResult(LogInResult l){ //todo NICK
    setState((){
      this.logResult = l;
    });
  }
   */


}
