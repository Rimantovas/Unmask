import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:unmaskapp/variable_classes/game_model.dart';

class ResultsGraph extends StatelessWidget {
  final Game game;
  final int index;
  final Color? color1;
  final Color? color2;
  final bool showResults;

  const ResultsGraph({
    Key? key,
    required this.game,
    required this.color1,
    required this.color2,
    required this.index,
    required this.showResults,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Material(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: width *
                    game.answers.values
                        .where((element) => element == game.votes[index])
                        .length /
                    game.players.length *
                    0.8,
                height: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      stops: const [0.0, 0.9],
                      colors: [color2!, color1!],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: AutoSizeText(game.votes[index],
                        minFontSize: 2,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 30))),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                game.answers.values
                    .where((element) => element == game.votes[index])
                    .length
                    .toString(),
                style: const TextStyle(fontSize: 30),
              )
            ],
          ),
          if (showResults)
            SizedBox(
              width: width,
              height: 100,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  //shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: game.answers.keys
                      .where((element) =>
                          game.answers[element] == game.votes[index])
                      .length,
                  itemBuilder: (context, index2) {
                    String player = game.answers.keys
                        .where((element) =>
                            game.answers[element] == game.votes[index])
                        .elementAt(index2);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: width * 0.2,
                          width: width * 0.2,
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
                                  //Colors.red,
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
                      ),
                    );
                    // return Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         boxShadow: const [
                    //           BoxShadow(
                    //               color: Colors.black26,
                    //               offset: Offset(0, 4),
                    //               blurRadius: 5.0)
                    //         ],
                    //         gradient: LinearGradient(
                    //           begin: Alignment.topLeft,
                    //           end: Alignment.bottomRight,
                    //           stops: const [0.5, 1.0],
                    //           colors: [
                    //             Theme.of(context).primaryColor,
                    //             Theme.of(context).colorScheme.secondary,
                    //           ],
                    //         ),
                    //         shape: BoxShape.circle),
                    //     padding: const EdgeInsets.all(5),
                    //     child: Center(
                    //       child: AutoSizeText(
                    //         player,
                    //         //minFontSize: 25,
                    //         maxLines: 1,

                    //         style: const TextStyle(
                    //             color: Colors.white, fontSize: 15),
                    //       ),
                    //     ),
                    //   ),
                    // );
                  }),
            ),
        ],
      ),
    );
  }
}
