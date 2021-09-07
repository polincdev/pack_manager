// @dart=2.9
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import '/GoogleMap.dart';


class TrackPage extends StatefulWidget {
  @override
  State<TrackPage> createState() {
    return TrackPageState();
  }
}

class TrackPageState extends State<TrackPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int currentPackMode=0;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabSelection);
  }



  void _handleTabSelection() {
    if (tabController.indexIsChanging) {
      switch (tabController.index) {
        case 0:
          currentPackMode=0;
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Page 1 tapped.'),
            duration: Duration(milliseconds: 500),
          ));
          break;
        case 1:
          currentPackMode=1;
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Page 2 tapped.'),
            duration: Duration(milliseconds: 500),
          ));
          break;
      }
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  QuerySnapshot cachedTrackPacks=null;
  QuerySnapshot cachedSendPacks=null;

  @override
  Widget build(BuildContext context) {
    bool emptyTrackPacks = true;

    return Scaffold(
      appBar: AppBar(
        title: Text("Śledzenie przesyłek"),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(icon: Icon(Icons.email), text: "ODBIERAM"),
            Tab(icon: Icon(Icons.mail), text: "NADAJE"),
          ],
        ),

      ),
      body: TabBarView(
        controller: tabController,
        children: [
          StreamBuilder(
              stream: getPackages(0),
              builder: (context, snapshot) {
                print("RET1=" + snapshot.hasData.toString());

                 if(snapshot.hasData) {
                   //Must cache and bring back cashed data bc snapshot.hasData may return false on Tabs switch
                   cachedTrackPacks=snapshot.data as QuerySnapshot;
                  return PackagesList(cachedTrackPacks);
                 }
                 else{
                   if(cachedTrackPacks!=null)
                      return PackagesList(cachedTrackPacks);
                   else
                      return  Center(child: Text("Brak paczek"));
                 }

              },
            ),

          StreamBuilder(
            stream: getPackages(1),
            builder: (context, snapshot) {
              print("RET2=" + snapshot.hasData.toString());

              if(snapshot.hasData) {
                //Must cache and bring back cashed data bc snapshot.hasData may return false on Tabs switch
                cachedSendPacks=snapshot.data as QuerySnapshot;
                return PackagesList(cachedSendPacks);
              }
              else{
                if(cachedSendPacks!=null)
                  return PackagesList(cachedSendPacks);
                else
                  return  Center(child: Text("Brak paczek"));
              }

            },
          ),

        ],
      ),

      floatingActionButtonLocation: emptyTrackPacks
          ? FloatingActionButtonLocation.endFloat
          : null,
      floatingActionButton: emptyTrackPacks ? FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {

          getPackNumDialog(context);
        },
      ) : null,


    );
  }


  TextEditingController _textFieldController;
  String valueText;
  String packNumber;

  Future<void> getPackNumDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Wprowadź numer przesyłki'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Numer przesyłki"),
            ),
            actions: <Widget>[

              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    packNumber = valueText;
                    insertPack("MojaPaka", packNumber,currentPackMode);
                    Navigator.pop(context);
                  });
                },
              ),

            ],
          );
        });
  }


  void insertPack(String name, String number, num packType) {
    User user = FirebaseAuth.instance.currentUser;

    try {
      FirebaseFirestore.instance.collection("Packages").add(
          {
            "ownerEmail": user.email,
            "stageDate": Timestamp.fromDate(DateTime.now().toUtc()),
            "name": name,
            "number": number,
            "stage": 0,
            "from": "N/A",
            "type":packType
          }
      );
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(e.toString())
        ),
      );
      // print("blad="+e.toString());
    }
  }

  Stream<QuerySnapshot> getPackages(int type) {
    User user = FirebaseAuth.instance.currentUser;

    Stream<QuerySnapshot> data= FirebaseFirestore.instance
        .collection("Packages")
        .where('ownerEmail', isEqualTo: user.email)
        .where('type', isEqualTo:type)
        .orderBy("stageDate", descending: true)
        .snapshots();

    print("QUESRYSNapshot="+data.length.toString() );

    return data;
  }

  _goBack(BuildContext context) {
    Navigator.pop(context);
  }


}


class PackagesList extends StatelessWidget {
  PackagesList(this.data);

  final QuerySnapshot data;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.yellow,
      child:
          ListView.builder(
              reverse: false,
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                var months = [
                  "January",
                  "February",
                  "March",
                  "April",
                  "May",
                  "June",
                  "July",
                  "August",
                  "September",
                  "October",
                  "November",
                  "December"
                ];

                DateTime when = data
                    .docs[index].get("stageDate")
                    .toDate()
                    .toLocal();

                print("PRINT=" + when.toString() + " " + data.docs[index].get("from").toString() );

                return Container(
                    child:PackCard(context,
                        "Paczka została odebrana z paczkomatu",
                        data.docs[index].get("from"),
                        "${when.day} ${months[when.month - 1]} ${when.year}")
                        .buildCard());
              },

      ),
    );
  }

}


abstract class ListItem {
  Widget buildTitle(BuildContext context);

  Widget buildSubtitle(BuildContext context);
}


class PackCard {

  final String status;
  final String sender;
  final String date;
  BuildContext context;

  PackCard(this.context, this.status, this.sender, this.date);

  Widget buildCard() {
    return Container(
      height: 150,
      margin: EdgeInsets.all(10),
      child: Card(
        elevation: 6,
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 3,
                child: Container(padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: Container(child: Text(
                          status),),),
                      Expanded(flex: 1, child: Container(child: Text(
                          "Nadawca"),),),
                      Expanded(flex: 1, child: Container(child: Text(sender,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1),),),
                      Expanded(flex: 1, child: Container(child: Text(date),),),
                    ],

                  ),
                ),),

              Expanded(flex: 1,
                child: Container(color: Colors.blueAccent,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          color: Colors.grey,
                          highlightColor: Colors.red,
                          hoverColor: Colors.green,
                          focusColor: Colors.purple,
                          splashColor: Colors.black,
                          disabledColor: Colors.orange,
                          iconSize: 48,
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            print("sdsds");
                          },
                        ),

                      ]
                  ),),),
            ],

          ),
        ),
      ),
    );
  }


}
