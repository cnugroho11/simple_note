import 'package:flutter/material.dart';
import 'package:simple_note/constant/theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:simple_note/model/note.dart';
import 'package:simple_note/db/notes_database.dart';
import 'package:simple_note/pages/edit_note_screen.dart';
import 'package:simple_note/pages/note_detail_screen.dart';
import 'package:simple_note/widgets/note_card_widget.dart';
import 'package:simple_note/widgets/note_container_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  late List<Note> notes;
  bool isLoading = false;
  bool isFloating = true;

  @override
  void initState() {
    scrollController.addListener(() {
      if(scrollController.offset >= scrollController.position.maxScrollExtent 
        && !scrollController.position.outOfRange) {
          setState(() {
            isFloating = false;
          });
        }
        if(scrollController.position.pixels <= (MediaQuery.of(context).size.height
        - MediaQuery.of(context).padding.top)  * (3/4)
        && !scrollController.position.outOfRange) {
          setState(() {
            isFloating = true;
          });
        }
    });
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
      appBar: AppBar(
        backgroundColor: draculaGrey,
        title: Text(
          'Notes',
          style: TextStyle(fontSize: 24),
        ),
        actions: [Icon(Icons.search), SizedBox(width: 12)],
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : notes.isEmpty
            ? Text(
          'No Notes',
          style: TextStyle(color: Colors.white, fontSize: 24),
        )
            : buildNotes(),
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          backgroundColor: draculaGrey,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EditNoteScreen()),
              );
              refreshNotes();
            },
          ),
        visible: isFloating,
      )
    );
  }

  Widget buildNotes() {
    return StaggeredGridView.countBuilder(
      controller: scrollController,
      padding: EdgeInsets.all(8),
      itemCount: notes.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final note = notes[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDetailScreen(noteId: note.id!),
            ));

            refreshNotes();
          },
          child: NoteContainerWidget(note: note, index: index),
        );
      },
    );
  }
}
