import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unmaskapp/database_services.dart';
import 'package:unmaskapp/game_screens/results_screen.dart';
import 'package:unmaskapp/game_screens/voting_screen.dart';
import 'package:unmaskapp/game_screens/waiting_screen.dart';
import 'package:unmaskapp/globals.dart';
import 'package:unmaskapp/variable_classes/game_model.dart';
import 'package:unmaskapp/variable_classes/questions_model.dart';

class ProviderSetup extends StatelessWidget {
  final String id;

  const ProviderSetup({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Game>(
          create: (_) => streamGame(id),
          initialData: Game.emptyGame(),
          catchError: (_, __) => Game.emptyGame(),
        ),
        if (role == "host") ChangeNotifierProvider(create: (_) => Questions([]))
      ],
      child: const ScreenPicker(),
    );
  }

  Stream<Game> streamGame(String id) {
    var ref = FirebaseFirestore.instance.collection('test').doc(id);
    return ref.snapshots().map((value) => Game.fromFirestore(value));
    // return ref.snapshots().map(
    //     (list) => list.docs.map((doc) => Game.fromFirestore(doc)).toList());
  }
}

class ScreenPicker extends StatelessWidget {
  const ScreenPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = Provider.of<Game>(context);
    Widget page = Container();

    if (screen.screen == 0) {
      page = const WaitingScreen();
    } else if (screen.screen == 1) {
      page = const VotingScreen();
    } else if (screen.screen == 2) {
      page = ResultsScreen();
    } else {
      page = Container(
          color: Colors.purple,
          child: const Center(child: Text("Something went wrong")));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (role == "host") {
              Navigator.pop(context);
            } else {
              DatabaseServices.leaveGame(screen.id).then((value) {
                Navigator.pop(context);
              });
            }
          },
        ),
        title: role == "host"
            ? Text(
                "Questions left: ${DatabaseServices.questions.length}",
                style: const TextStyle(fontSize: 15),
              )
            : null,
      ),
      body: page,
    );
  }
}
