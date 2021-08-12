import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_note/model/note.dart';

class NoteCardWidget extends StatelessWidget {
  final Note note;
  final int index;

  const NoteCardWidget({
    Key? key,
    required this.note,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
