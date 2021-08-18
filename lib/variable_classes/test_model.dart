import 'package:cloud_firestore/cloud_firestore.dart';

class TestModel {
  List<String> names = [];
  String question = "";
  int screen = 0;

  TestModel(this.names, this.question, this.screen);

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      List<String>.from(json['arr'].map((x) => x)),
      json['question'] as String,
      json['screen'] as int,
    );
  }
  factory TestModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    TestModel game = TestModel.fromJson(documentSnapshot.data()!);
    return game;
  }
}
