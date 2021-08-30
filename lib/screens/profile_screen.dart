import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unmaskapp/globals.dart';
import 'package:unmaskapp/widgets/CustomButton.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final controller = TextEditingController(text: userName);

  Future<void> setUsername(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }

  @override
  Widget build(BuildContext context) {
    controller.text = userName ?? "";
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          body: Column(
            children: [
              const Text(
                "Add yourself a cool name",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 5)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 5)),
                    hintText: controller.text == "" ? "NAME" : "",
                  ),
                  onEditingComplete: () async {
                    if (controller.text != "") {
                      userName = controller.text;
                      setUsername(controller.text);
                      FocusManager.instance.primaryFocus!.unfocus();
                    }
                  },
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: CustomButton(function: () {}, text: "Change")),
              Expanded(child: Image.asset('assets/images/profile.png'))
            ],
          )),
    );
  }
}
