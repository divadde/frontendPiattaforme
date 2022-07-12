
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/Model.dart';
import '../../model/objects/Biglietto.dart';
import '../widgets/TicketCard.dart';

class ListaBiglietti extends StatefulWidget {
  String email;
  ListaBiglietti({Key? key, required this.email}) : super(key: key);


  State<StatefulWidget> createState() => _BigliettiState(email);

}

class _BigliettiState extends State<ListaBiglietti> {
  List<Biglietto>? biglietti;
  String? mailUtente;

  _BigliettiState(String email){
    mailUtente=email;
    _riempiBiglietti();
  }

  @override
  Widget build(BuildContext context) {
    if(biglietti!=null) {
      return Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.4,
              child: Image.asset("images/home.png",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fitWidth ,
              ),
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    "Lista biglietti acquistati",
                    style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.purple,
                    ),
                  ),
                  bottom(),
                ],
              ),
            ),
          ],
        )
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Image.asset("images/home.png",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fitWidth ,
            ),
          ),
        ]
      )
    );
  }

  Widget bottom() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: biglietti!.length,
          itemBuilder: (context, index) {
            return TicketCard(
              biglietto: biglietti![index],
            );
          },
        ),
      ),
    );
  }

  void _riempiBiglietti() {
    Model.sharedInstance.getBigliettiByEmail(mailUtente!).then((result) {
      //print("risultato: ");
      //print(result);
      setState(() {
        biglietti = result;
      });
    });
  }

}