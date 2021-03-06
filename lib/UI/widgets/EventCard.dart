import 'package:frontend_ticketstore/UI/widgets/BuyButton.dart';
import 'package:frontend_ticketstore/UI/widgets/GenericPopUp.dart';
import 'package:frontend_ticketstore/model/objects/Evento.dart';
import 'package:flutter/material.dart';
import 'package:frontend_ticketstore/model/support/LogInResult.dart';

import '../../model/Model.dart';
import '../../model/objects/Biglietto.dart';
import '../../model/support/LoginState.dart';
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
            Text(
              event.giorno,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              event.orario,
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
        BuyButton(onPressed: () {
          if(!(LoginState.sharedInstance.getLoginState()==LogInResult.logged)) {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    GenericPopUp(label: "Devi aver effettuato il login per poter acquistare un biglietto.").build(context)
            );
          }
          else {
              if (settore.getValue()!=null && posto.getValue()!=null) {
                  acquista(settore.getValue(), posto.getValue()).then((risposta) {
                    print("risposta nel metodo: ");
                    print(risposta);
                    if (risposta!.compareTo("TICKET_ALREADY_BOUGHT") == 0) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              GenericPopUp(
                                  label: "Hai gi?? acquistato un biglietto per questo evento.")
                                  .build(context)
                      );
                    }
                    else {
                      if (risposta!.compareTo("NO_SEATS_AVAILABLE") == 0) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                GenericPopUp(
                                    label: "Non ci sono pi?? posti per questo evento.")
                                    .build(context)
                        );
                      }
                      else {
                        if (risposta!.compareTo("SEAT_ALREADY_OCCUPIED") == 0) {
                          print("posto gi?? occupato");
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  GenericPopUp(label: "Posto gi?? occupato.")
                                      .build(context)
                          );
                        }
                        else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  GenericPopUp(
                                      label: "Biglietto acquistato con successo.")
                                      .build(context)
                          );
                        }
                      }
                    }
                  });
              }
              else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => GenericPopUp(label: "Devi inserire tribuna e posto.").build(context)
                );
              }
          };
        }),
      ],
    );
  }


  Future<String> acquista(String? settore, String? posto) async {
    //print("pronto all'acquisto");
    //print(settore);
    //print(posto);
    Biglietto? biglietto;
    await Model.sharedInstance.getUserEmail().then((mail) async {
      //print("mail ottenuta: ");
      //print(mail);
      await Model.sharedInstance.getUserByEmail(mail).then((utente) {
        //print("utente ottenuto: ");
        //print(utente);
        biglietto = Biglietto(
            settore: settore!, posto: posto!, evento: event, utente: utente);
        print("biglietto composto: ");
        print(biglietto);
      });
    });
    return Model.sharedInstance.aggiungiBiglietto(biglietto!);
  }

}
