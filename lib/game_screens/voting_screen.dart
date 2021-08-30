import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unmaskapp/database_services.dart';
import 'package:unmaskapp/globals.dart';
import 'package:unmaskapp/variable_classes/game_model.dart';
import 'package:unmaskapp/widgets/CustomVotingButton.dart';

class VotingScreen extends StatelessWidget {
  const VotingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    if (game.answers.keys.length == game.players.length && role == "host") {
      DatabaseServices.changeScreen(game.id, 2);
    }
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AutoSizeText(
                game.question ?? "No questions left",
                maxLines: 2,
                minFontSize: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 45),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var vote in game.votes)
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        game.answers.keys.contains(userName)
                            ? game.answers[userName] == vote
                                ? Colors.black26
                                : Colors.transparent
                            : Colors.transparent,
                        BlendMode.srcATop),
                    child: CustomVotingButton(
                        function: () {
                          if (!game.answers.keys.contains(userName)) {
                            DatabaseServices.vote(game.id, vote);
                          }
                        },
                        voted: game.answers.keys.contains(userName),
                        text: vote),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Image.asset(
                'assets/images/choose.png',
                fit: BoxFit.fitWidth,
              ),
            )
          ],
        ),
      ),
    );
  }
}
