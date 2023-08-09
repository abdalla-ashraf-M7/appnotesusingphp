// ignore_for_file: must_be_immutable

import 'package:appnotesusingphp/components/crud.dart';
import 'package:appnotesusingphp/components/textform.dart';
import 'package:appnotesusingphp/components/valid.dart';
import 'package:appnotesusingphp/constants/links.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formstate = GlobalKey();
  Crud _crud = Crud();

  @override
  Widget build(BuildContext context) {
    signUp() async {
      if (formstate.currentState!.validate()) {
        var response = await _crud.postRequest(linksignup, {"username": username.text, "email": email.text, "password": password.text});
        if (response['status'] == "sucess") {
          Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
          print("*************************work****************");
        } else {
          print("sign up failed");
        }
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView(shrinkWrap: true, children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    /* Image.asset(
                      "images/2.jpeg",
                      height: 200,
                    ), */
                    Image.network(
                      "https://th.bing.com/th/id/R.62a4a12f395ab308ee1bedae9493191a?rik=Foa4NIKSqj5S%2fA&pid=ImgRaw&r=0",
                      height: 200,
                    ),
                    Textform(
                      valido: (val) {
                        return ValidOrNot(val!, 20, 3);
                      },
                      formstate: email,
                      hint: 'email',
                    ),
                    Textform(
                      valido: (val) {
                        return ValidOrNot(val!, 20, 3);
                      },
                      formstate: username,
                      hint: 'username',
                    ),
                    Textform(
                        valido: (val) {
                          return ValidOrNot(val!, 20, 3);
                        },
                        hint: 'password',
                        formstate: password),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                          onPressed: () async {
                            await signUp();
                          },
                          child: Text('Sign Up')),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("login");
                      },
                      child: Text("Log In"),
                    )
                  ],
                ))
          ]),
        ],
      ),
    );
  }
}
