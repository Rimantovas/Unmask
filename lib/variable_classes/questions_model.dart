import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Questions extends ChangeNotifier {
  List<String> allQuestions = [];

  Questions(this.allQuestions);

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      List<String>.from(json['questions'].map((val) => val)),
    );
  }

  factory Questions.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    Questions game = Questions.fromJson(documentSnapshot.data()!);
    return game;
  }
}
