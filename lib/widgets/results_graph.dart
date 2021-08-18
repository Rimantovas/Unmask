import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:unmaskapp/variable_classes/game_model.dart';

class ResultsGraph extends StatelessWidget {
  final Game game;
  final int index;
  final Color? color1;
  final Color? color2;

  const ResultsGraph(
      {Key? key,
      required this.game,
      required this.color1,
      required this.color2,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Material(
      child: Row(
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
                  stops: const [0.0, 0.4],
                  colors: [color2!, color1!],
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Center(
                child: AutoSizeText(game.votes[index],
                    maxLines: 1, style: const TextStyle(fontSize: 30))),
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
    );
  }
}
