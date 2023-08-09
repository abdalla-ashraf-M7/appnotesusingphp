// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:appnotesusingphp/components/crud.dart';
import 'package:appnotesusingphp/components/textform.dart';
import 'package:appnotesusingphp/components/valid.dart';
import 'package:appnotesusingphp/constants/links.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, required this.noteid, required this.notetitle, required this.notecontent, required this.imagename});
  final String noteid;
  final String notetitle;
  final String notecontent;
  final String imagename;
  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  @override
  void initState() {
    super.initState();
    title.text = widget.notetitle;
    content.text = widget.notecontent;
  }

  File? myfile;
  GlobalKey<FormState> formsate = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  Crud _crud = Crud();

  Future<void> editNote() async {
    if (formsate.currentState!.validate()) {
      var response;
      if (myfile == null) {
        response = await _crud.postRequest(linkupdatenote, {
          "title": title.text,
          "content": content.text,
          "noteid": widget.noteid,
          "imagename": widget.imagename,
        });
      } else {
        response = await _crud.postRequestWithFile(
            linkupdatenote,
            {
              "title": title.text,
              "content": content.text,
              "noteid": widget.noteid,
              "imagename": widget.imagename,
            },
            myfile!);
      }
      if (response['status'] == 'sucess') {
        Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Note')),
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
                await editNote();
              },
              child: Text("Updat Note"),
            ),
          ],
        ),
      ),
    );
  }
}
