import 'package:flutter/material.dart';
import 'package:simple_note/constant/theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:simple_note/db/notes_database.dart';
import 'package:simple_note/model/note.dart';

class EncryptedNotesPage extends StatefulWidget {
  const EncryptedNotesPage({Key? key}) : super(key: key);

  @override
  _EncryptedNotesPageState createState() => _EncryptedNotesPageState();
}

class _EncryptedNotesPageState extends State<EncryptedNotesPage> {
  late List<Note> notes;
  bool isLoading = false;
  bool isLongPress = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    this.notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: encryptedNotes(),
      ),
    );
  }

  Widget encryptedNotes() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.only(top: 30, right: 8, left: 8, bottom: 70),
      itemCount: notes.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 20,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final note = notes[index];

        return GestureDetector();
      },
    );
  }
}
