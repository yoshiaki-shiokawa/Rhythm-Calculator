import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rhythm_calculator/Assets/r_c_navigation_icons.dart';
import 'package:rhythm_calculator/Pages/MelodyPage.dart';
import 'package:rhythm_calculator/Pages/ToolPage.dart';
import 'package:rhythm_calculator/Pages/rhythmPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
        cardColor: Colors.teal.shade100,
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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    var maxHeight = size.height - padding.bottom - padding.top;
    List<Widget> pages = [RhythmPage(), MelodyPage(), ToolPage()];

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
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(RCNavigation.icon_rhythm), label: 'Rhythm'),
          BottomNavigationBarItem(
              icon: Icon(RCNavigation.icon_pitch), label: 'Melody'),
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
