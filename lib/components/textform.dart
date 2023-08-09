// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Textform extends StatelessWidget {
  final String hint;
  final TextEditingController formstate;
  final String? Function(String?) valido;

  Textform({Key? key, required this.hint, required this.formstate, required this.valido});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        validator: valido,
        controller: formstate,
        decoration: InputDecoration(
            hintText: "$hint",
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1), borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }
}
