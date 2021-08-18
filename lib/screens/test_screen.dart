// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unmaskapp/variable_classes/test_model.dart';

class TestScreen extends StatelessWidget {
  final String documentID;
  const TestScreen({Key? key, required this.documentID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<TestModel>(
          create: (_) => streamOfUsers(documentID),
          initialData: TestModel([], "", 0),
        ),
      ],
      child: Scaffold(
        body: ScreenPicker(),
      ),
    );
  }

  Stream<TestModel> streamOfUsers(String id) {
    var ref = FirebaseFirestore.instance.collection('test').doc(id);
    return ref.snapshots().map((value) => TestModel.fromFirestore(value));
    // return ref.snapshots().map(
    //     (list) => list.docs.map((doc) => Game.fromFirestore(doc)).toList());
  }
}

class ScreenPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = Provider.of<TestModel>(context);
    if (screen.screen == 0) {
      return ListScreen();
    } else {
      return QuestionScreen();
    }
  }
}

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final players = Provider.of<TestModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: Column(children: <Widget>[
        Flexible(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: players.names.length,
              itemBuilder: (context, index) {
                String player = players.names[index];
                return ListTile(
                  title: Text(player),
                );
              }),
        ),
      ]),
    );
  }
}

class QuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final question = Provider.of<TestModel>(context);

    return Material(
      child: Center(
        child: Text(
          question.question,
          style: const TextStyle(fontSize: 35),
        ),
      ),
    );
  }
}
