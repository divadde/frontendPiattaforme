import 'package:frontend_ticketstore/UI/widgets/CircularIconButton.dart';
import 'package:frontend_ticketstore/UI/widgets/InputField.dart';
import 'package:frontend_ticketstore/UI/widgets/EventCard.dart';
import 'package:frontend_ticketstore/model/Model.dart';
import 'package:frontend_ticketstore/model/objects/Evento.dart';
import 'package:flutter/material.dart';


//OK MA AGGIUSTA QUELLO CHE MANCA
class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _searching = false;
  List<Evento>? _events;

  TextEditingController _searchFiledController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            top(),
            bottom(),
          ],
        ),
      ),
    );
  }

  Widget top() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: [
          Flexible(
            child: InputField(
              labelText: "Ricerca evento",
              controller: _searchFiledController,
              onSubmit: (value) {
                print(_searchFiledController.text); //OK
                _search();
              },
            ),
          ),
          CircularIconButton(
            icon: Icons.search_rounded,
            onPressed: () {
              print("IconButton"); //OK
              print(_searchFiledController.text);
              _search();
            },
          ),
        ],
      ),
    );
  }

  Widget bottom() {
    return  !_searching ?
              _events == null ?
                SizedBox.shrink() :
                _events!.length == 0 ?
                  noResults() :
                  yesResults() :
              CircularProgressIndicator();
  }

  Widget noResults() {
    return Text("Nessun risultato!");
  }

  Widget yesResults() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: _events!.length,
          itemBuilder: (context, index) {
            return EventCard(
              event: _events![index],
            );
          },
        ),
      ),
    );
  }

  void _search() {
    setState(() {
      _searching = true;
      _events = null;
    });
    Model.sharedInstance.searchEvent(_searchFiledController.text).then((result) {
      print("risultato: ");
      print(result);
      setState(() {
        _searching = false;
        _events = result;
      });
    });
  }


}
