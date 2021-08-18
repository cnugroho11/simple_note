import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_note/constant/theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:simple_note/model/note.dart';
import 'package:simple_note/db/notes_database.dart';
import 'package:simple_note/pages/edit_note_screen.dart';
import 'package:simple_note/pages/note_detail_screen.dart';
import 'package:simple_note/widgets/note_card_widget.dart';
import 'package:simple_note/widgets/note_container_widget.dart';

class RegularNotesPage extends StatefulWidget {
  const RegularNotesPage({Key? key}) : super(key: key);

  @override
  _RegularNotesPageState createState() => _RegularNotesPageState();
}

class _RegularNotesPageState extends State<RegularNotesPage> {
  late List<Note> notes;
  bool isLoading = false;
  bool isLongPress = false;

  @override
  void initState() {
    super.initState();
    isLongPress = false;
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
        child: isLoading ? CircularProgressIndicator() : notes.isEmpty 
        ? Text( 
          'No Notes',
          style: TextStyle(color: Colors.white, fontSize: 24),
          ): regularNotes(),
      ),
    );
  }

  Widget regularNotes() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.only(top: 30, right: 8, left: 8, bottom: 70),
      itemCount: notes.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 20,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final note = notes[index];
    
        return GestureDetector(
          onLongPress: () {
            setState(() {
              if(isLongPress) isLongPress = false;
              else isLongPress = true;
            });
          },
          onTap: () async {
            if (isLongPress) {
              isLongPress = false;
            } else {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailScreen(noteId: note.id!),
              ));
              refreshNotes();
            }
          },
          child: NoteContainerWidget(note: note, index: index, isLongPress: isLongPress,),
        );
      },
    );
  }
}
