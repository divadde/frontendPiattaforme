import 'package:frontend_ticketstore/model/support/LogInResult.dart';

//singleton. stato del login condiviso da tutte le componenti grafiche
class LoginState {
  static LoginState sharedInstance = LoginState();
  LogInResult _loginState = LogInResult.error_wrong_credentials;

  LogInResult getLoginState(){
    return _loginState;
  }

  void setLoginState(LogInResult l){
    _loginState=l;
  }

}