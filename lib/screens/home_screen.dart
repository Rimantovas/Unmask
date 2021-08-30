// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:mock_data/mock_data.dart';
import 'package:unmaskapp/database_services.dart';
import 'package:unmaskapp/game_screens/screen_picker.dart';
import 'package:unmaskapp/globals.dart';
import 'package:unmaskapp/screens/join_game.dart';
import 'package:unmaskapp/screens/profile_screen.dart';
import 'package:unmaskapp/widgets/CustomButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<void> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('name') ?? mockName();
  }

  @override
  Widget build(BuildContext context) {
    if (userName == null) {
      getUsername();
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProfileScreen()));
              },
              icon: const Icon(Icons.person))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo2.png',
              fit: BoxFit.fitWidth,
            ),
            //const Text("Unmask", style: TextStyle(fontSize: 70)),

            CustomButton(
                function: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => JoinGame()));
                },
                text: "Join Game"),
            const Text(
              "OR",
              style: TextStyle(fontSize: 15),
            ),
            CustomButton(
                function: () async {
                  String id = await DatabaseServices.createGame();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProviderSetup(
                                id: id,
                              ))).then((value) {
                    DatabaseServices.deleteGame(id);
                  });
                },
                text: "Create Game"),
          ],
        ),
      ),
    );
  }
}
