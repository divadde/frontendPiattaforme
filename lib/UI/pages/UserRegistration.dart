import 'package:frontend_ticketstore/UI/widgets/CircularIconButton.dart';
import 'package:frontend_ticketstore/UI/widgets/InputField.dart';
import 'package:frontend_ticketstore/model/Model.dart';
import 'package:frontend_ticketstore/model/objects/Utente.dart';
import 'package:flutter/material.dart';


class UserRegistration extends StatefulWidget {
  UserRegistration({Key? key}) : super(key: key);


  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  bool _adding = false;
  late User _justAddedUser;

  TextEditingController _firstNameFiledController = TextEditingController();
  TextEditingController _lastNameFiledController = TextEditingController();
  TextEditingController _telephoneNumberFiledController = TextEditingController();
  TextEditingController _emailFiledController = TextEditingController();
  TextEditingController _addressFiledController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text( "registrazione",
                style: TextStyle(
                  fontSize: 50,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                //todo, modifica. Non richiedo alcune informazioni per l'applicazione
                children: [
                  InputField(
                    labelText: "nome",
                    controller: _firstNameFiledController,
                  ),
                  InputField(
                    labelText: "cogn",
                    controller: _lastNameFiledController,
                  ),
                  InputField(
                    labelText: "nome",
                    controller: _telephoneNumberFiledController,
                  ),
                  InputField(
                    labelText: "nome",
                    controller: _emailFiledController,
                  ),
                  InputField(
                    labelText: "nome",
                    controller: _addressFiledController,
                  ),
                  CircularIconButton(
                    icon: Icons.person_rounded,
                    onPressed: () {
                      _register();
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: _adding ?
                      CircularProgressIndicator() :
                      _justAddedUser != null ?
                      Text(
                          AppLocalizations.of(context).translate("just_added") + ":" + _justAddedUser.firstName + " " + _justAddedUser.lastName + "!"
                      ) :
                      SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _register() {
    setState(() {
      _adding = true;
      _justAddedUser = null;
    });
    User user = User(
      firstName: _firstNameFiledController.text,
      lastName: _lastNameFiledController.text,
      telephoneNumber: _telephoneNumberFiledController.text,
      email: _emailFiledController.text,
      address: _addressFiledController.text,
    );
    Model.sharedInstance.addUser(user).then((result) {
      setState(() {
        _adding = false;
        _justAddedUser = result;
      });
    });
  }


}
