import 'dart:io';

import 'package:estadisticas_soquets/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Bon Jovi', votes: 5),
    Band(id: '3', name: 'Evanescence', votes: 5),
    Band(id: '4', name: 'Whitney Houston', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bandnames',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) {
          return _bandTile(bands[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( DismissDirection direction ){
        //Llamar borrado al server
      },
      background: Container(
        color: Colors.redAccent,
        child: const Align(
          alignment: Alignment.center,
          child: Text('Delete band',style: TextStyle(color: Colors.white),),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                  child: const Text('Add'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => addBandToList(textController.text)),
            ],
          );
        },
      );
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('New band name'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Add'),
                onPressed: () => addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Dismiss'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      bands.add(Band(
        id: DateTime.now().toString(),
        name: name,
        votes: 0,
      ));
      setState(() {
        
      });
    }
    Navigator.pop(context);
  }
}
