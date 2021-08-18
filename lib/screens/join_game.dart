// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:unmaskapp/database_services.dart';
import 'package:unmaskapp/game_screens/screen_picker.dart';
import 'package:unmaskapp/game_screens/waiting_screen.dart';
import 'package:unmaskapp/globals.dart';

class JoinGame extends StatelessWidget {
  JoinGame({Key? key}) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Column(
            children: [
              const Text(
                "Type in the code given by the host",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  "GAME PIN",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 5)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 5)),
                    hintText: "GAME PIN",
                  ),
                  onEditingComplete: () async {
                    if (controller.text != "") {
                      if (controller.text.length == 6) {
                        bool result =
                            await DatabaseServices.joinGame(controller.text);
                        FocusManager.instance.primaryFocus!.unfocus();
                        if (result) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      ProviderSetup(id: controller.text)));
                        } else {
                          controller.clear();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            "Wrong game pin",
                            style: TextStyle(color: Colors.white),
                          )));
                        }
                      }
                    }
                  },
                ),
              ),
              Expanded(child: Image.asset('assets/images/typewriter.png'))
            ],
          ),
        ),
      ),
    );
  }
}
