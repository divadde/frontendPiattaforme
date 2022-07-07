import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_ticketstore/UI/pages/ListaBiglietti.dart';
import 'package:frontend_ticketstore/model/support/LoginState.dart';
import 'package:http/http.dart';
import '../../model/Model.dart';
import '../../model/objects/Utente.dart';
import '../../model/objects/UtenteCompleto.dart';
import '../../model/support/LogInResult.dart';
import '../widgets/TextInputField.dart';
import 'Layout.dart';

//todo aggiusta
class Login extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _PersonalAreaState();

}

enum page{
  login, registration
}

class _PersonalAreaState extends State<Login>{
  page p = page.login;
  late Response data;
  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  TextEditingController _RegcontrollerNome = TextEditingController();
  TextEditingController _RegcontrollerCogn = TextEditingController();
  TextEditingController _RegcontrollerMail = TextEditingController();
  TextEditingController _RegcontrollerPass = TextEditingController();
  TextEditingController _RegcontrollerUser = TextEditingController();
  TextEditingController _RegcontrollerCF = TextEditingController();
  TextEditingController _RegcontrollerCitta = TextEditingController();
  TextEditingController _RegcontrollerEta = TextEditingController();


  @override
  Widget build(BuildContext context) {
    print("ciao login");
    return p == page.login?
    LoginPage() : RegistrationPage();
  }

  Widget LoginPage(){
    return  Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.4,
              child: Icon(Icons.home_rounded),
              ),
            Center(
              child:SizedBox(
                width: 400,
                height: 400,
                child: Column(
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextInputField(hint:"user", controller: _controllerUser,submit: loginS),
                    TextInputField(hint:"password", controller: _controllerPassword,submit: loginS,),
                    IconButton( onPressed: login,
                      icon: Icon(Icons.login, size: 25,),),
                    Text("oppure"),
                    IconButton(
                      onPressed: () {
                        setState((){p= page.registration;});
                      },
                      icon:  Icon(
                          size: 25,
                          Icons.app_registration
                      ),
                    ),
                    Text("registrati ora"),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget RegistrationPage(){
    return  Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.4,
            ),
            Center(
              child:SizedBox(
                width: 400,
                height: 800,
                child: Column(
                  children: [
                    const Text(
                      "Registrazione",
                      style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextInputField(hint:"user",controller: _RegcontrollerUser,),
                    TextInputField(hint:"mail",controller: _RegcontrollerMail,),
                    TextInputField(hint:"password",controller: _RegcontrollerPass,),
                    TextInputField(hint:"nome",controller: _RegcontrollerNome,),
                    TextInputField(hint:"cognome",controller: _RegcontrollerCogn,),
                    TextInputField(hint:"codice fiscale", controller: _RegcontrollerCF),
                    TextInputField(hint:"eta",controller: _RegcontrollerEta,),
                    TextInputField(hint:"citta",controller: _RegcontrollerCitta,),
                    IconButton(
                      onPressed: registrati, //todo perché non visualizza?
                      icon:  Icon(
                          size: 25,
                          Icons.app_registration
                      ),
                    ),
                    Text("registrati ora"),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }


  void registrati(){
    print("pronti a registrarci");
    /*
    setState((){
      p = page.progress;
    });
     */
    UtenteCompleto u = UtenteCompleto(
        username: _RegcontrollerUser.text,
        password: _RegcontrollerPass.text,
        utente: Utente(
            email: _RegcontrollerMail.text,
            nome: _RegcontrollerNome.text,
            cognome: _RegcontrollerCogn.text, 
            citta: _RegcontrollerCitta.text,
            eta: int.parse(_RegcontrollerEta.text),
            cf: _RegcontrollerCF.text,
            //id: null
        )
    );
    Model.sharedInstance.registraUtente(u).then((value) { //todo
      print("chiamata al model fatta");
      if( value.compareTo("registrazione completata") == 0) {
        setState((){
          print("registrazione completata!");
          _RegcontrollerEta.clear();
          _RegcontrollerCitta.clear();
          _RegcontrollerCogn.clear();
          _RegcontrollerNome.clear();
          _RegcontrollerCF.clear();
          _RegcontrollerPass.clear();
          _RegcontrollerUser.clear();
          _RegcontrollerMail.clear();
          //_alert = Text(""); //todo, cosa fa alert?
          p = page.login;
        });
      }else{
        setState((){
          p = page.registration;
          /*
          _alert = const Text( //todo
            "qualcosa è andato storto",
            style: TextStyle(
                color: Colors.red
            ),
           */
        });
      }
    });
  }


  void loginS(String s){
    login();
  }
  void login() async{
    print("user: "+ _controllerUser.text);
    print("pass: "+ _controllerPassword.text);
    LogInResult res = await Model.sharedInstance.logIn(_controllerUser.text, _controllerPassword.text);
    print("risultato del login: ");
    print(res);
    LoginState.sharedInstance.setLoginState(res);
    print("proviamo ora a ricevere informazioni sullo user");
    String mailUser = await Model.sharedInstance.getUserEmail();
    print("abbiamo ottenuto: ");
    print(mailUser);
    setState((){
      //ListaBiglietti.setMailUtente(mailUser);
      Layout.setLogState(mailUser);
    });
  }

}