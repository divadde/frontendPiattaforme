class Utente {
  //late id;
  late String cf;
  late String nome;
  late String cognome;
  late int eta;
  late String citta;
  late String email;


  Utente({/*required this.id,*/ required this.cf, required this.nome, required this.cognome, required this.eta, required this.citta, required this.email});

  factory Utente.fromJson(Map<String, dynamic> json) {
    return Utente(
      //id: json['id'],
      cf: json['cf'],
      nome: json['nome'],
      cognome: json['cognome'],
      eta: json['eta'],
      citta: json['citta'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    //'id': id,
    'cf': cf,
    'nome': nome,
    'cognome': cognome,
    'eta': eta,
    'citta': citta,
    'email': email,
  };

  @override
  String toString() {
    return nome + " " + cognome;
  }


}