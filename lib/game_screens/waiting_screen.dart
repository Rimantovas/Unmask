// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unmaskapp/database_services.dart';
import 'package:unmaskapp/globals.dart';
import 'package:unmaskapp/variable_classes/game_model.dart';
import 'package:unmaskapp/widgets/CustomButton.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (role == "host") {
      //atsisiusti visus questions
    }
    final game = Provider.of<Game>(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: role == "host"
            ? CustomButton(
                function: () {
                  if (game.players.length >= 3) {
                    DatabaseServices.newVoting(game);
                  }
                },
                text: game.players.length < 3
                    ? "Need ${3 - game.players.length} more players to start"
                    : "Start game")
            : null,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset(
                  'assets/images/waiting2.png',
                ),
              ),
              const Text(
                "ROOM CODE:",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
              Center(
                child: Text(
                  game.id,
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Meet the club:",
                style: TextStyle(fontSize: 25),
              ),
              Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    //shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: game.players.length,
                    itemBuilder: (context, index) {
                      String player = game.players[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 4),
                                    blurRadius: 5.0)
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: const [0.5, 1.0],
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              ),
                              shape: BoxShape.circle),
                          padding: EdgeInsets.all(15),
                          child: Center(
                            child: Text(
                              player,
                              //minFontSize: 25,
                              maxLines: 1,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerScreen extends StatelessWidget {
  const AnswerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset(
                'assets/images/waiting2.png',
              ),
            ),
            const Text(
              "ANSWERS:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Meet the club:",
              style: TextStyle(fontSize: 25),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: game.answers.length,
                  itemBuilder: (context, index) {
                    String key = game.answers.keys.elementAt(index);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          key,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          game.answers[key]!,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
