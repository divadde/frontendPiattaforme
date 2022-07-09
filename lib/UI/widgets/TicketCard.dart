import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/objects/Biglietto.dart';

class TicketCard extends StatelessWidget {
  final Biglietto biglietto;

  TicketCard({Key? key, required this.biglietto}) : super(key: key);

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
              biglietto.evento.nome, //todo funziona?
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              "Settore: " + biglietto.settore,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              "Posto: " +biglietto.posto,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }


}