import 'package:frontend_ticketstore/UI/widgets/BuyButton.dart';
import 'package:frontend_ticketstore/model/objects/Evento.dart';
import 'package:flutter/material.dart';

import '../../model/Model.dart';
import '../../model/objects/Biglietto.dart';
import '../../model/objects/Utente.dart';


class EventCard extends StatelessWidget {
  final Evento event;

  EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              event.nome,
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              event.citta,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            BuyButton(onPressed: acquista),
          ],
        ),
      ),
    );
  }

  void acquista() {
    print("pronto all'acquisto");
    String settore = "A"; //todo in maniera randomica
    String posto = "1";
    Model.sharedInstance.getUserEmail().then((mail) {
      print("mail ottenuta: ");
      print(mail);
      Model.sharedInstance.getUserByEmail(mail).then((utente) {
        print("utente ottenuto: ");
        print(utente);
        Biglietto biglietto = Biglietto(
            settore: settore, posto: posto, evento: event, utente:utente);
        print("biglietto composto: ");
        print(biglietto);
        Model.sharedInstance.aggiungiBiglietto(biglietto);
      });
    });
    print("biglietto acquistato");
  }


}
