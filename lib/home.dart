// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:appnotesusingphp/components/notecard.dart';
import 'package:appnotesusingphp/constants/links.dart';
import 'package:appnotesusingphp/editnote.dart';
import 'package:appnotesusingphp/main.dart';
import 'package:appnotesusingphp/models/modelclass.dart';
import 'package:flutter/material.dart';
import 'components/crud.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Crud _crud = Crud();
  getnotes() async {
    var response = await _crud.postRequest(linkviewnote, {"userid": sharedprefs!.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                sharedprefs!.clear();
                Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
        title: Text('Notes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnote");
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(children: [
          FutureBuilder(
            future: getnotes(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data['status'] == 'failed') {
                  return Center(child: Text("No Notes Yet"));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data['data'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return NoteCard(
                      tap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditNote(
                            noteid: snapshot.data['data'][index]['notes_id'],
                            notecontent: snapshot.data['data'][index]['notes_content'],
                            notetitle: snapshot.data['data'][index]['notes_title'],
                            imagename: snapshot.data['data'][index]['notes_image'],
                          ),
                        ));
                      },
                      modelclass: Modelclass.fromJson(snapshot.data['data'][index]),
                      delete: () async {
                        var response = await _crud.postRequest(linkdeletenote, {
                          "noteid": snapshot.data['data'][index]['notes_id'],
                          "imagename": snapshot.data['data'][index]['notes_image'],
                        });
                        if (response["status"] == "sucess") {
                          print("**************work***********");
                          Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
                        } else {
                          print("***********************not work*************");
                        }
                      },
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading...");
              }
              return Text("error");
            },
          ),
        ]),
      ),
    );
  }
}
