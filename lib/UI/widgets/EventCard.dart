import 'package:frontend_ticketstore/UI/widgets/BuyButton.dart';
import 'package:frontend_ticketstore/UI/widgets/CircularIconButton.dart';
import 'package:frontend_ticketstore/model/objects/Evento.dart';
import 'package:flutter/material.dart';

import '../../model/Model.dart';
import '../../model/objects/Biglietto.dart';
import '../../model/objects/Utente.dart';
import 'SceltaPosto.dart';
import 'SceltaSettore.dart';


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
            RaisedButton(
              child: Text(
              'Scegli settore e posto',
              style: TextStyle(
                color: Colors.white,
                ),
              ),
              color: Theme.of(context).primaryColor,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        popUpEvento(context),
                  );
                }
            )
          ],
        ),
      ),
    );
  }


  Widget popUpEvento(BuildContext context) {
    SceltaSettore settore = SceltaSettore();
    SceltaPosto posto = SceltaPosto();
    return new AlertDialog(
      title: const Text('Scelta settore e posto'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          settore,
          posto,
      /*
      DropdownButton(
      value: settore,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) { () =>
            settore = newValue!;
          },
        items: <String>['Gradinata', 'Tribuna', 'Curva']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
         DropdownButton<String>(
            value: posto,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) { () =>
              posto = newValue!;
            },
            items: <String>['1', '2', '3', '4', '5', '6', '7']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
       */
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Chiudi'),
        ),
        BuyButton(onPressed: () =>
            acquista(settore.getValue(),posto.getValue())),
      ],
    );
  }


  void acquista(String? settore, String? posto) {
    print("pronto all'acquisto");
    print(settore);
    print(posto);
    Model.sharedInstance.getUserEmail().then((mail) {
      print("mail ottenuta: ");
      print(mail);
      Model.sharedInstance.getUserByEmail(mail).then((utente) {
        print("utente ottenuto: ");
        print(utente);
        Biglietto biglietto = Biglietto(
            settore: settore!, posto: posto!, evento: event, utente:utente);
        print("biglietto composto: ");
        print(biglietto);
        Model.sharedInstance.aggiungiBiglietto(biglietto);
      });
    });
    print("biglietto acquistato");
  }


}
