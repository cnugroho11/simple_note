import 'package:flutter/material.dart';
import 'package:simple_note/db/notes_database.dart';
import 'package:simple_note/model/note.dart';
import 'package:simple_note/constant/theme.dart';

class NoteDetailScreen extends StatefulWidget {
  final int noteId;

  const NoteDetailScreen({ 
    Key? key,
    required this.noteId, 
  }) : super(key: key);

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    refreshNote();
    super.initState();
  }

  Future refreshNote() async{
    setState(() => isLoading = true);
    this.note = await NotesDatabase.instance.readNote(widget.noteId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}