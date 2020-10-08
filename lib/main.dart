import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rythm Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.tealAccent.shade400,
        accentColor: Colors.indigo.shade900,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Rythm Calculator'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          child: ListView(
        children: const <Widget>[
          DrawerHeader(
            child: Text("Rythm Calculator",
                style: TextStyle(color: Colors.white, fontSize: 25)),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          )
        ],
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: GridView.count(
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                scrollDirection: Axis.vertical,
                crossAxisCount: 3,
                children: [
                  GridTile(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Icon(Icons.note),
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  GridTile(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Icon(Icons.note),
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  GridTile(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Icon(Icons.note),
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  GridTile(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Icon(Icons.note),
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  GridTile(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Icon(Icons.note),
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  GridTile(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Icon(Icons.note),
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  GridTile(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Icon(Icons.note),
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  GridTile(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Icon(Icons.note),
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  GridTile(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Icon(Icons.note),
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Rythm'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Pitch'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Tools'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
