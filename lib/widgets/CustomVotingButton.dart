// ignore_for_file: file_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomVotingButton extends StatelessWidget {
  final VoidCallback function;
  final String text;
  final bool voted;

  CustomVotingButton({
    required this.function,
    required this.text,
    required this.voted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
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
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
          elevation: MaterialStateProperty.all(0),
          minimumSize: MaterialStateProperty.all(const Size(100, 100)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: voted ? null : function,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
