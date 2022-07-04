//OK
class Evento {
  late int id; //todo vabene questo late?
  late String nome;
  late String citta;
  late int posti_occupati;
  late int massimo_posti;
  late String organizzatore;


  Evento({required this.id, required this.nome, required this.citta, required this.posti_occupati,required this.massimo_posti, required this.organizzatore});


  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      id: json['id'],
      nome: json['nome'],
      citta: json['citta'],
      posti_occupati: json['posti_occupati'],
      massimo_posti: json['massimo_posti'],
      organizzatore: json ['organizzatore'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'citta': citta,
    'posti_occupati': posti_occupati,
    'massimo_posti': massimo_posti,
    'organizzatore': organizzatore,
  };

  @override
  String toString() {
    return nome;
  }


}