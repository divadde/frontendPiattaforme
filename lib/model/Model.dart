import 'dart:async';
import 'dart:convert';
import 'package:frontend_ticketstore/model/managers/RestManager.dart';
import 'package:frontend_ticketstore/model/objects/AuthenticationData.dart';
import 'package:frontend_ticketstore/model/objects/Biglietto.dart';
import 'package:frontend_ticketstore/model/objects/Evento.dart';
import 'package:frontend_ticketstore/model/objects/Utente.dart';
import 'package:frontend_ticketstore/model/objects/UtenteCompleto.dart';
import 'package:frontend_ticketstore/model/support/Constants.dart';
import 'package:frontend_ticketstore/model/support/LogInResult.dart';

//todo aggiungi acquisto biglietto
class Model {
  static Model sharedInstance = Model();

  RestManager _restManager = RestManager();
  late AuthenticationData _authenticationData;


  //ok
  Future<LogInResult> logIn(String username, String password) async {
    try{
      Map<String, String> params = Map();
      params["grant_type"] = "password";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["username"] = username;
      params["password"] = password;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      print("post fatta: ");
      print(result);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      print(_authenticationData);
      if ( _authenticationData.hasError() ) {
        if ( _authenticationData.error == "Invalid user credentials" ) {
          return LogInResult.error_wrong_credentials;
        }
        else if ( _authenticationData.error == "Account is not fully set up" ) {
          return LogInResult.error_not_fully_setupped;
        }
        else {
          return LogInResult.error_unknown;
        }
      }
      _restManager.token = _authenticationData.accessToken;
      Timer.periodic(Duration(seconds: (_authenticationData.expiresIn! - 50)), (Timer t) {
        _refreshToken();
      });
      return LogInResult.logged;
    }
    catch (e) {
      return LogInResult.error_unknown;
    }
  }

  //ok
  Future<bool> _refreshToken() async {
    try {
      Map<String, String> params = Map();
      params["grant_type"] = "refresh_token";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData.refreshToken!;
      String result = await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGIN, params, type: TypeHeader.urlencoded);
      _authenticationData = AuthenticationData.fromJson(jsonDecode(result));
      if ( _authenticationData.hasError() ) {
        return false;
      }
      _restManager.token = _authenticationData.accessToken;
      return true;
    }
    catch (e) {
      return false;
    }
  }

  //ok
  Future<bool> logOut() async {
    try{
      Map<String, String> params = Map();
      _restManager.token = null;
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["refresh_token"] = _authenticationData.refreshToken!;
      await _restManager.makePostRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.REQUEST_LOGOUT, params, type: TypeHeader.urlencoded);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  //ok
  Future<String> getUserEmail() async {
    String ret = json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_AUTHENTICATION_SERVER, Constants.USER_INFO, null))['email'];
    print(ret);
    return ret;
  }

  //todo prova
  Future<Utente> getUserByEmail(String email) async {
    Map<String, String> params = Map();
    params["email"] = email;
    String rawResult = await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_USER_BY_MAIL, params);
    return Utente.fromJson(jsonDecode(rawResult));
  }

  //ok
  Future<List<Biglietto>> getBigliettiByEmail(String email) async{
    Map<String, String> params = Map();
    params["email"] = email;
    return List<Biglietto>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_GET_TICKETS, params)).map((i) => Biglietto.fromJson(i)).toList());
  }

  //ok
  Future<List<Evento>> searchEvent(String nome) async {
    Map<String, String> params = Map();
    params["nome"] = nome;
    print("Search eventi:" +nome);
    return List<Evento>.from(json.decode(await _restManager.makeGetRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_SEARCH_EVENTS, params)).map((i) => Evento.fromJson(i)).toList());
  }


  //todo
  Future<String> registraUtente(UtenteCompleto user) async {
      return await _restManager.makePostRequest(Constants.ADDRESS_STORE_SERVER, Constants.REQUEST_ADD_USER, user);
  }


  //aggiungi acquisto biglietto todo


}
