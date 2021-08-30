// ignore_for_file: void_checks, avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mock_data/mock_data.dart';
import 'package:unmaskapp/globals.dart';
import 'package:unmaskapp/variable_classes/game_model.dart';

class DatabaseServices {
  static var ref = FirebaseFirestore.instance.collection('test');
  static List<String> questions = [];

  static Future<void> changeScreen(String id, int newscreen) async {
    ref.doc(id).update({
      'screen': newscreen,
    });
  }

  static Future<void> newVoting(Game game) async {
    int random1 = Random().nextInt(game.players.length);
    int random2 = Random().nextInt(game.players.length);
    int shouldshow = Random().nextInt(3);
    int questionIndex = Random().nextInt(questions.length);
    while (random1 == random2) {
      random2 = Random().nextInt(game.players.length);
    }
    ref.doc(game.id).update({
      'question': questions[questionIndex],
      'answers': {},
      'screen': 1,
      'votes': [game.players[random1], game.players[random2]],
      'show': shouldshow < 2 ? false : true
    });
    questions.removeAt(questionIndex);
  }

  static Future<void> vote(String id, String answer) async {
    ref.doc(id).update({
      'answers.$userName': answer,
    });
  }

  static Future<String> createGame() async {
    role = "host";
    questions = List.from(allQuestions);
    String newID = Random().nextInt(999999).toString().padLeft(6, '0');
    userName = userName ?? mockName();
    ref.doc(newID).set({
      'answers': {},
      'players': [userName],
      'question': "",
      'screen': 0,
      'votes': [],
      'show': false
    });
    return newID;
  }

  static Future<bool> joinGame(String id) async {
    try {
      role = "guest";
      userName = userName ?? mockName();
      var check = await ref.doc(id).get();
      if (check.exists) {
        ref.doc(id).update({
          'players': FieldValue.arrayUnion([userName]),
        });
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<void> leaveGame(String id) async {
    var check = await ref.doc(id).get();
    if (check.exists) {
      ref.doc(id).update({
        'players': FieldValue.arrayRemove([userName])
      });
    }
  }

  static Future<void> deleteGame(String id) async {
    ref.doc(id).delete();
  }
}
