import 'Organizzatore.dart';

class Evento {
  late int id;
  late String nome;
  late String citta;
  late int posti_occupati;
  late int massimo_posti;
  late String giorno;
  late String orario;
  late Organizzatore organizzatore;


  Evento({required this.id, required this.nome, required this.citta, required this.posti_occupati,required this.massimo_posti, required this.giorno, required this.orario, required this.organizzatore});


  factory Evento.fromJson(Map<String, dynamic> json) {
    String dataOra = DateTime.fromMillisecondsSinceEpoch(json['giorno']).toString();
    return Evento(
      id: json['id'],
      nome: json['nome'],
      citta: json['citta'],
      posti_occupati: json['posti_occupati'],
      massimo_posti: json['massimo_posti'],
      giorno: dataOra.split(" ")[0],
      orario: json['orario'].toString(),
      organizzatore: Organizzatore.fromJson(json['organizzatore']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'citta': citta,
    'posti_occupati': posti_occupati,
    'massimo_posti': massimo_posti,
    "giorno": giorno,
    "orario": orario,
    'organizzatore': organizzatore,
  };

  @override
  String toString() {
    return nome;
  }


}