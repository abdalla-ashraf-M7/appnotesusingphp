// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:appnotesusingphp/components/crud.dart';
import 'package:appnotesusingphp/components/textform.dart';
import 'package:appnotesusingphp/components/valid.dart';
import 'package:appnotesusingphp/constants/links.dart';
import 'package:appnotesusingphp/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  File? myfile;
  GlobalKey<FormState> formsate = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  Crud _crud = Crud();

  addnote() async {
    if (myfile == null) {
      return Text("you should choose image");
    }
    if (formsate.currentState!.validate()) {
      var response = await _crud.postRequestWithFile(
          linkaddnote,
          {
            "title": title.text,
            "content": content.text,
            "userid": sharedprefs!.getString("id"),
          },
          myfile!);
      if (response['status'] == 'sucess') {
        Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Note')),
      body: Form(
        key: formsate,
        child: ListView(
          shrinkWrap: true,
          children: [
            Textform(
              hint: "title",
              formstate: title,
              valido: (val) {
                return ValidOrNot(val!, 50, 1);
              },
            ),
            Textform(
              hint: "content",
              formstate: content,
              valido: (val) {
                return ValidOrNot(val!, 255, 1);
              },
            ),
            MaterialButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    height: 140,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Please Choose Image",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                            myfile = File(xFile!.path);
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "From Gallary",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera);
                            myfile = File(xFile!.path);
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "From Camera",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              color: myfile == null ? Colors.grey : Colors.blue,
              child: Text("Add Image"),
            ),
            ElevatedButton(
              onPressed: () async {
                await addnote();
              },
              child: Text("Add Note"),
            ),
          ],
        ),
      ),
    );
  }
}
