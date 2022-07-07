import 'package:frontend_ticketstore/UI/widgets/BuyButton.dart';
import 'package:frontend_ticketstore/model/objects/Evento.dart';
import 'package:flutter/material.dart';


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
                fontSize: 40,
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

  void acquista(){
    //scelgo settore e posto in maniera randomica
    //evento lo ho già
    //ottengo lo user dal token
  }


}
