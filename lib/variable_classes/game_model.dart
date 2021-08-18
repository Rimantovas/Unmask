import 'package:cloud_firestore/cloud_firestore.dart';

class Game {
  String id = "";
  List<String> players = [];
  Map<String, String> answers = {};
  String? question;
  List<String> votes = [];
  int screen = 0;
  bool showResults = false;
  Game(this.players, this.answers, this.question, this.screen, this.votes,
      this.showResults);

  // getQuestion() {
  //   int random = Random().nextInt(questions.length);
  //   question = questions.elementAt(random);
  //   questions.removeAt(random);
  // }

  factory Game.emptyGame() {
    return Game([], {}, null, 0, [], false);
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      List<String>.from(json['players'].map((val) => val)),
      Map<String, String>.from(json['answers']),
      json['question'] as String,
      json['screen'] as int,
      List<String>.from(json['votes'].map((val) => val)),
      json['show'] as bool,
    );
  }

  factory Game.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    Game game = Game.fromJson(documentSnapshot.data()!);
    game.id = documentSnapshot.id;
    return game;
  }
}
