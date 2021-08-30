import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unmaskapp/database_services.dart';
import 'package:unmaskapp/globals.dart';
import 'package:unmaskapp/variable_classes/game_model.dart';
import 'package:unmaskapp/widgets/CustomButton.dart';
import 'package:unmaskapp/widgets/results_graph.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen({Key? key}) : super(key: key);

  final List<Color?> colors = [
    Colors.green[900],
    Colors.green[400],
    Colors.red[900],
    Colors.red[400],
  ];

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: role == "host"
          ? CustomButton(
              function: () {
                if (game.players.length >= 3) {
                  DatabaseServices.newVoting(game);
                }
              },
              text: game.players.length < 3
                  ? "Need ${3 - game.players.length} to continue"
                  : "Continue")
          : null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: AutoSizeText(
              game.question ?? "No questions left",
              minFontSize: 2,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(fontSize: 45),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ResultsGraph(
            game: game,
            color1: colors[0],
            color2: colors[1],
            index: 0,
            showResults: game.showResults,
          ),
          if (game.showResults)
            SizedBox(
              width: width,
              height: 100,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  //shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: game.answers.keys
                      .where(
                          (element) => game.answers[element] == game.votes[0])
                      .length,
                  itemBuilder: (context, index) {
                    String player = game.answers.keys
                        .where(
                            (element) => game.answers[element] == game.votes[0])
                        .elementAt(index);
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
                        padding: const EdgeInsets.all(5),
                        child: Center(
                          child: AutoSizeText(
                            player,
                            minFontSize: 2,
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          if (!game.showResults)
            const SizedBox(
              height: 100,
            ),
          ResultsGraph(
            game: game,
            color1: colors[2],
            color2: colors[3],
            index: 1,
            showResults: game.showResults,
          ),
          if (game.showResults)
            SizedBox(
              width: width,
              height: 100,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  //shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: game.answers.keys
                      .where(
                          (element) => game.answers[element] == game.votes[1])
                      .length,
                  itemBuilder: (context, index) {
                    String player = game.answers.keys
                        .where(
                            (element) => game.answers[element] == game.votes[1])
                        .elementAt(index);
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
                        padding: const EdgeInsets.all(5),
                        child: Center(
                          child: AutoSizeText(
                            player,
                            minFontSize: 2,
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
        ],
      ),
    );
  }
}
