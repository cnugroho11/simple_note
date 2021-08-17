import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_note/constant/theme.dart';
import 'package:simple_note/model/note.dart';

class NoteContainerWidget extends StatelessWidget {
  final Note note;
  final int index;

  const NoteContainerWidget({ 
    Key? key,
    required this.note,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().format(note.createdTime);

    return Column(
      children: [
        Container(
          height: 200,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: draculaGrey
            )
          ),
          child: Text(
            note.description,
            style: TextStyle(
              color: draculaWhite,
              
            ),
          )
        ),
        Text(
          note.title,
          style: TextStyle(
            color: draculaWhite,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          time,
          style: TextStyle(
            color: draculaWhite
          ),
        ),
      ],
    );
  }
}