// @dart=2.9
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/GoogleMap.dart';
import '/main.dart';



Widget buildDrawer(BuildContext context){
  //User user = FirebaseAuth.instance.currentUser;

  return Drawer(
  child: ListView(
    children:<Widget>[
      UserAccountsDrawerHeader(
        accountName: Text(""),
        accountEmail: Text(''),
          decoration: BoxDecoration(color:Colors.blueGrey),
        currentAccountPicture: CircleAvatar(backgroundImage: AssetImage('assets/logo.png')   ),
      ),
      ListTile(
          title:Text("Archiwum przesyłek"),
          subtitle: Text(""),
        leading: Icon(Icons.view_list, color:Colors.blueGrey),
      ),
      ListTile(
        title:Text("Mapa punktów"),
        subtitle: Text(""),
        leading: Icon(Icons.map, color:Colors.blueGrey),
        onTap: (){
          Navigator.pushReplacement(
              context, MaterialPageRoute(
              builder: (context) => MapSample()
          )
          );

         },
      ),
      ListTile(
        title:Text("Ustawienia"),
        subtitle: Text(""),
        leading: Icon(Icons.settings, color:Colors.blueGrey),
      ),
      ListTile(
        title:Text("Pomoc"),
        subtitle: Text(""),
        leading: Icon(Icons.info, color:Colors.blueGrey),
      ),
      ListTile(
        title:Text("O aplikacji"),
        subtitle: Text(""),
        leading: Icon(Icons.info, color:Colors.blueGrey),
      ),
      SizedBox(
        child:Container(color:Colors.blueGrey),
        height: 1,
          width:double.infinity,
      ),
      ListTile(
        title:Text("Wyloguj"),
        subtitle: Text(""),
        trailing: Icon(Icons.logout, color:Colors.blueGrey),
      ),
    ],


  ),

  );
}

