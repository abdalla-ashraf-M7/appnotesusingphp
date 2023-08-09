// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_final_fields, unnecessary_string_interpolations, avoid_print, must_be_immutable

import 'package:appnotesusingphp/components/crud.dart';
import 'package:appnotesusingphp/components/textform.dart';
import 'package:appnotesusingphp/constants/links.dart';
import 'package:appnotesusingphp/main.dart';
import 'package:flutter/material.dart';

import 'components/valid.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formstate = GlobalKey();
  Crud _crud = Crud();
  @override
  Widget build(BuildContext context) {
    logIn() async {
      if (formstate.currentState!.validate()) {
        var response = await _crud.postRequest(linklogin, {"email": email.text, "password": password.text});
        if (response['status'] == "sucess") {
          sharedprefs!.setString('id', '${response['data']['users_id'].toString()}');
          sharedprefs!.setString('username', '${response['data']['users_username']}');
          sharedprefs!.setString('email', '${response['data']['users_email']}');
          sharedprefs!.setString('password', '${response['data']['users_password']}');
          Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
        } else {
          print("error");
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
                    /*  Image.asset(
                      "images/1.jpeg",
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
                        hint: 'password',
                        formstate: password),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            logIn();
                          },
                          child: Text('Log in')),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("signup");
                      },
                      child: Text("Sign up"),
                    )
                  ],
                ))
          ]),
        ],
      ),
    );
  }
}
