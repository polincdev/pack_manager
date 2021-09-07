// @dart=2.9
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/PackDrawer.dart';

import 'SendPage.dart';
import 'TrackPage.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key,   this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  List<Widget> _widgetOptions = <Widget>[
    TrackPage(),
    SendPage()
  ];

  int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),

        actions: [
          IconButton(
              tooltip: "Change your bio",
              icon: Icon(Icons.edit),
              onPressed: () {}

          ),

        ],
      ),
      drawer: buildDrawer(context),


      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
// sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white60,
// sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.white30,
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow))),
        // sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[

            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Śledź',
              backgroundColor: Colors.blueAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_upward),
              label: 'Nadaj',
              backgroundColor: Colors.blueGrey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.doorbell),
              label: 'Sprawdź',
              backgroundColor: Colors.lightBlue,


            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          onTap: (index) {

            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),

      body: _widgetOptions.elementAt(selectedIndex),
    );


  }


}
