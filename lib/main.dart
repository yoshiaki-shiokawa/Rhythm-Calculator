import 'package:flutter/material.dart';
import 'package:RhytmCalculator/r_c_navigation_icons.dart';
import 'package:RhytmCalculator/musical_notes_icons.dart';
import 'package:RhytmCalculator/musical_rests_icons.dart';
import 'package:RhytmCalculator/sound_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rhythm Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.tealAccent.shade400,
        accentColor: Colors.indigo.shade900,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Rhythm Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SoundPlayer player = SoundPlayer();
  int _selectedIndex = 0;
  int _selectedPad = 0;
  List<List<int>> _notesNumber = [
    [1, 2, 3, 4, 5, 6],
    [11, 12, 13, 14, 15, 16],
    [-1, -2, -3, -4, -5, -6],
    [-11, -12, -13, -14, -15, -16]
  ];
  List<List<int>> _track = []; // Notes 1,2,3,4,5,6 pitch velocity*10
  List<List<Widget>> notesAndRests = [
    [
      Icon(MusicalNotes.semibreve),
      Icon(MusicalNotes.minim),
      Icon(MusicalNotes.crotchet),
      Icon(MusicalNotes.quaver),
      Icon(MusicalNotes.semiquaver),
      Icon(MusicalNotes.demisemiquaver)
    ],
    [
      Icon(MusicalNotes.dottedsemibreve),
      Icon(MusicalNotes.dottedminim),
      Icon(MusicalNotes.dottedcrotchet),
      Icon(MusicalNotes.dottedquaver),
      Icon(MusicalNotes.dottedsemiquaver),
      Icon(MusicalNotes.dotteddemisemiquaver)
    ],
    [
      Icon(MusicalRests.semibreve),
      Icon(MusicalRests.minim),
      Icon(MusicalRests.crotchet),
      Icon(MusicalRests.quaver),
      Icon(MusicalRests.semiquaver),
      Icon(MusicalRests.demisemiquaver)
    ],
    [
      Icon(MusicalRests.dottedsemibreve),
      Icon(MusicalRests.dottedminim),
      Icon(MusicalRests.dottedcrotchet),
      Icon(MusicalRests.dottedquaver),
      Icon(MusicalRests.dottedsemiquaver),
      Icon(MusicalRests.dotteddemisemiquaver)
    ]
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Icon _selectNoteRest() {
    if (_selectedPad == 0 || _selectedPad == 1) {
      return Icon(MusicalRests.crotchet);
    } else if (_selectedPad == 2 || _selectedPad == 3) {
      return Icon(MusicalNotes.crotchet);
    } else {
      return Icon(Icons.note);
    }
  }

  Icon _selectPlayPause() {
    if (player.isPlaying) {
      return Icon(Icons.stop);
    } else {
      return Icon(Icons.play_arrow_rounded);
    }
  }

  List<Widget> _generateNotes() {
    List<Widget> line = List<Widget>();

    for (List<int> x in _track) {
      if (x[0] > 0) {
        if (x[0] < 10) {
          line.add(Container(
            child: FittedBox(child: notesAndRests[0][x[0] - 1]),
            height: 50,
            width: 30,
          ));
        } else {
          line.add(Container(
            child: FittedBox(child: notesAndRests[1][x[0] - 11]),
            height: 50,
            width: 30,
          ));
        }
      } else {
        if (x[0] > -10) {
          line.add(Container(
            child: FittedBox(child: notesAndRests[2][-1 * x[0] - 1]),
            height: 50,
            width: 30,
          ));
        } else {
          line.add(Container(
            child: FittedBox(child: notesAndRests[3][-1 * x[0] - 11]),
            height: 50,
            width: 30,
          ));
        }
      }
    }

    return line;
  }

  List<Widget> _generateButtons() {
    List<Widget> buttons = List<Widget>();

    buttons.add(GestureDetector(
      child: GridTile(
        child: Container(
          alignment: Alignment.center,
          child: FittedBox(
              child: Text(
                "  C  ",
                style: TextStyle(fontSize: 80, fontFamily: "VarelaRound"),
              ),
              fit: BoxFit.contain),
          decoration: BoxDecoration(
              color: Colors.cyan, borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      onTap: () {
        setState(() {
          _track.clear();
        });
      },
    ));
    buttons.add(GestureDetector(
      child: GridTile(
        child: Container(
          alignment: Alignment.center,
          child: FittedBox(
              child: Text(
                "DEL",
                style: TextStyle(fontSize: 80, fontFamily: "VarelaRound"),
              ),
              fit: BoxFit.contain),
          decoration: BoxDecoration(
              color: Colors.cyan, borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      onTap: () {
        setState(() {
          _track.removeLast();
        });
      },
    ));
    buttons.add(GridTile(
      child: Container(
        child: FittedBox(
          child: Icon(Icons.save_alt_rounded),
          fit: BoxFit.contain,
        ),
        decoration: BoxDecoration(
            color: Colors.cyan, borderRadius: BorderRadius.circular(10.0)),
      ),
    ));
    buttons.add(GestureDetector(
      child: GridTile(
        child: Container(
          child: FittedBox(child: _selectPlayPause(), fit: BoxFit.contain),
          decoration: BoxDecoration(
              color: Colors.cyan, borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      onTap: () {
        setState(() {
          if (!player.isPlaying) {
            player.clearTrack();
            player.convert(_track);
          }
          player.handleTogglePlayPause();
        });
      },
    ));

    for (int x = 0; x < 3; x++) {
      buttons.add(GestureDetector(
        child: GridTile(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: notesAndRests[_selectedPad][x],
                fit: BoxFit.contain,
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.cyan, borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        onTap: () {
          setState(() {
            _track.add([_notesNumber[_selectedPad][x], 60, 7]);
          });
        },
      ));
    }

    buttons.add(GestureDetector(
      child: GridTile(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: _selectNoteRest(),
              fit: BoxFit.contain,
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.cyan, borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      onTap: () {
        setState(() {
          if (_selectedPad == 0 || _selectedPad == 1) {
            _selectedPad = 2;
          } else if (_selectedPad == 2 || _selectedPad == 3) {
            _selectedPad = 0;
          }
        });
      },
    ));

    for (int x = 3; x < 6; x++) {
      buttons.add(GestureDetector(
        child: GridTile(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: notesAndRests[_selectedPad][x],
                fit: BoxFit.contain,
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.cyan, borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        onTap: () {
          setState(() {
            _track.add([_notesNumber[_selectedPad][x], 60, 7]);
          });
        },
      ));
    }

    buttons.add(GestureDetector(
      child: GridTile(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: Icon(Icons.circle),
              fit: BoxFit.scaleDown,
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.cyan, borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      onTap: () {
        setState(() {
          if (_selectedPad == 0) {
            _selectedPad = 1;
          } else if (_selectedPad == 1) {
            _selectedPad = 0;
          } else if (_selectedPad == 2) {
            _selectedPad = 3;
          } else if (_selectedPad == 3) {
            _selectedPad = 2;
          }
        });
      },
    ));

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    var maxHeight = size.height - padding.bottom - padding.top;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child: ListView(
        children: const <Widget>[
          DrawerHeader(
            child: Text("Rhythm Calculator",
                style: TextStyle(color: Colors.white, fontSize: 25)),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          )
        ],
      )),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: maxHeight - (((size.width - 50) / 4) * 3 + 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    ListView(
                      scrollDirection: Axis.horizontal,
                      children: _generateNotes(),
                    )
                  ],
                ),
              ),
            )),
            SizedBox(
              height: ((size.width - 50) / 4) * 3 + 40,
              child: GridView.count(
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 4,
                children: _generateButtons(),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(RCNavigation.icon_rhythm), label: 'Rhythm'),
          BottomNavigationBarItem(
              icon: Icon(RCNavigation.icon_pitch), label: 'Pitch'),
          BottomNavigationBarItem(
              icon: Icon(RCNavigation.icon_tool), label: 'Tools'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
