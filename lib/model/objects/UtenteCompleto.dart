import 'Utente.dart';

class UtenteCompleto {
  Utente utente;
  String username;
  String password;


  UtenteCompleto({ required this.utente, required this.username, required this.password});

  factory UtenteCompleto.fromJson(Map<String, dynamic> json) {
    return UtenteCompleto(
        utente: Utente.fromJson(json['utente']),
        username: json['username'],
        password: json['password']
    );
  }

  Map<String, dynamic> toJson() => {
    'utente': utente.toJson(),
    'username': username,
    'password':password
  };

  @override
  String toString() {
    return username;
  }


}