
import 'Evento.dart';
import 'Utente.dart';

class Biglietto {
  late int id; //todo vabene questo late?
  late String settore;
  late String posto;
  late Utente utente;
  late Evento evento;

  Biglietto({required this.id, required this.settore, required this.posto, required this.utente,required this.evento});


  factory Biglietto.fromJson(Map<String, dynamic> json) {
    return Biglietto(
      id: json['id'],
      settore: json['settore'],
      posto: json['posto'],
      utente: Utente.fromJson(json['utente']),
      evento: Evento.fromJson(json['evento']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'settore': settore,
    'posto': posto,
    'utente': utente,
    'evento': evento,
  };

  @override
  String toString() {
    return settore + "," +posto+ "," +utente.toString()+";" + evento.toString();
  }


}