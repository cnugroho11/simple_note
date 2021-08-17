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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  late List<Note> notes;
  bool isLoading = false;

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
      extendBody: true,
      backgroundColor: background,
      body: Center(
        child: isLoading ? CircularProgressIndicator() : notes.isEmpty 
        ? Text( 
          'No Notes',
          style: TextStyle(color: Colors.white, fontSize: 24),
          ): buildNotes(),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
        color: draculaGrey,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: draculaGreen,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Regular'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lock),
              label: 'Encrypted'
            ),
          ],
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: draculaPurple,
        child: Icon(Icons.add,),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditNoteScreen()),
          );
          refreshNotes();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildNotes() {
    return StaggeredGridView.countBuilder(
      controller: scrollController,
      padding: EdgeInsets.only(top: 30, right: 8, left: 8, bottom: 70),
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
