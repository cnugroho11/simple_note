import 'package:flutter/material.dart';
import 'package:simple_note/constant/theme.dart';
import 'package:simple_note/db/notes_database.dart';
import 'package:simple_note/model/note.dart';
import 'package:simple_note/pages/edit_note_screen.dart';
import 'package:simple_note/pages/regular_notes_page.dart';
import 'package:simple_note/pages/encrypted_notes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Note> notes;
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    RegularNotesPage(),
    EncryptedNotesPage()
  ];

  @override
  void initState(){
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    this.notes = await NotesDatabase.instance.readAllNotes();
  }

  void _onNavbarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
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
          currentIndex: _selectedIndex,
          onTap: _onNavbarTapped,
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
}
