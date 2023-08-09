// ignore_for_file: sort_child_properties_last, prefer_const_constructors
import 'package:appnotesusingphp/constants/links.dart';
import 'package:appnotesusingphp/models/modelclass.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final void Function()? tap;
  final void Function()? delete;
  /* final String title;
  final String content; */
  final Modelclass modelclass;
  const NoteCard({super.key, required this.tap, required this.delete, required this.modelclass});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: Image.network(
                "$linkimageroot/${modelclass.notesImage}",
                fit: BoxFit.fill,
                height: 100,
                width: 100,
              ),
              flex: 1,
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                subtitle: Text(modelclass.notesContent!),
                title: Text(modelclass.notesTitle!),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: delete,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
