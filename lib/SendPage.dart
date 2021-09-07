// @dart=2.9
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';



class  SendPage extends StatefulWidget{
  @override
  State<SendPage> createState() {
    return SendPagePageState();
  }
}
class SendPagePageState extends State<SendPage>     {

  double sendPrice=12.99;
  bool delPack2Pack=true;
  bool delPack2Home=false;
  bool packSizeSmall=true;
  bool packSizeMed=false;
  bool packSizeBig=false;
  double packSizeSmallVal=12.99;
  double packSizeMedVal=13.99;
  double packSizeBigVal=15.49;

  void onDelPack2PackChanged(bool val){
    setState(() {
        delPack2Pack=true;
        delPack2Home=false;

        packSizeSmallVal=12.99;
        packSizeMedVal=13.99;
        packSizeBigVal=15.49;
        if(packSizeSmall)
        sendPrice=packSizeSmallVal;
        else  if(packSizeMed)
          sendPrice=packSizeMedVal;
        else  if(packSizeBig)
          sendPrice=packSizeBigVal;
    });
  }
  void onDelPack2HomeChanged(bool val){
    setState(() {
      delPack2Pack=false;
      delPack2Home=true;

      packSizeSmallVal=14.99;
      packSizeMedVal=16.49;
      packSizeBigVal=19.99;
      if(packSizeSmall)
        sendPrice=packSizeSmallVal;
      else  if(packSizeMed)
        sendPrice=packSizeMedVal;
      else  if(packSizeBig)
        sendPrice=packSizeBigVal;
     });
  }
  void packSizeSmallChanged(bool val){
    setState(() {
      packSizeSmall=true;
      packSizeMed=false;
      packSizeBig=false;
      sendPrice=packSizeSmallVal;
    });
  }
  void packSizeMedChanged(bool val){
    setState(() {
      packSizeSmall=false;
      packSizeMed=true;
      packSizeBig=false;
      sendPrice=packSizeMedVal;
    });
  }
  void packSizeBigChanged(bool val){
    setState(() {
      packSizeSmall=false;
      packSizeMed=false;
      packSizeBig=true;
      sendPrice=packSizeBigVal;
    });
  }

  void packInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Jak spakować przesyłkę?"),
          content: new Text("Zadbaj o odpowiednie zabezpieczenie przesyłki i zmierz jej gabaryt."),
          actions: <Widget>[
            Container(  width: double.infinity, margin: EdgeInsets.all(15),
              decoration: BoxDecoration( border: Border.all(color:  Colors.black) ),
              child:    TextButton(
              style:  TextButton.styleFrom(
                minimumSize: Size(1500, 75),
                backgroundColor: Colors.yellowAccent,
                padding: EdgeInsets.all(0),

              ),
              child: Text( "Wszystko jasne", textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 24), ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),),
          ],
        );
      },
    );
  }


  void sendInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Jak nadawać przesyłki?"),
          content: new Text("Nadanie paczki w aplikacji jest szybkie, proste i wygodne."),
          actions: <Widget>[
            Container(  width: double.infinity, margin: EdgeInsets.all(15),
              decoration: BoxDecoration( border: Border.all(color:  Colors.black) ),
              child:    TextButton(
                style:  TextButton.styleFrom(
                  minimumSize: Size(1500, 75),
                  backgroundColor: Colors.yellowAccent,
                  padding: EdgeInsets.all(0),

                ),
                child: Text( "Wszystko jasne", textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 24), ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),),
          ],
        );
      },
    );
  }


  TapGestureRecognizer  packInfoTapper=TapGestureRecognizer();


  @override
  void initState(){
    super.initState();
    //init infor
    packInfoTapper.onTap=() async {
      packInfoDialog(context);
    };
   }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: Text("Nadaj przesyłkę"),


        ),
       body: new Container(
         padding: EdgeInsets.all(10),
        color: Colors.white,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         mainAxisSize: MainAxisSize.max,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
             Expanded( flex:4, child:  SingleChildScrollView(
               physics: AlwaysScrollableScrollPhysics(),
               padding:EdgeInsets.symmetric(horizontal: 0.0,vertical: 0.0),
               child:  Column(
               mainAxisAlignment: MainAxisAlignment.start,
               mainAxisSize: MainAxisSize.max,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Container(height: 40,width: double.infinity,padding: EdgeInsets.all(0),
                     child:Text("TYP NADANIA", style: TextStyle(
                     color: Colors.grey[800],
                     fontWeight: FontWeight.normal,
                     fontSize: 20)),),
               GestureDetector(
                   onTap: () {
                     onDelPack2PackChanged(!delPack2Pack);
                   },
                   child:   Container(height: 100,width: double.infinity,padding: EdgeInsets.all(5),margin: EdgeInsets.all(5),
                   decoration: BoxDecoration( color:Colors.white, border: Border.all(color: delPack2Pack?Colors.grey:Colors.black12) ),
                    child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     mainAxisSize: MainAxisSize.max,
                     children: [
                       Checkbox(
                       value: delPack2Pack,
                       onChanged:  onDelPack2PackChanged
                         ),
                       Container(  height: 75,width: 75,
                           child:  Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children:[
                                Icon(Icons.grid_4x4),
                                Text("PakBox", style: TextStyle( color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 20)),
                              ],
                        )),
                       Icon(Icons.arrow_forward),
                       Container(  height: 75,width: 75,
                           child:  Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             mainAxisSize: MainAxisSize.max,
                             children:[
                               Icon(Icons.grid_4x4),
                               Text("PakBox", style: TextStyle( color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 20)),
                             ],
                           )),
                      ],
                   ),),),
                 GestureDetector(
                   onTap: () {
                     onDelPack2HomeChanged(!delPack2Home);
                   },
                   child: Container(height: 100,width: double.infinity,padding: EdgeInsets.all(5),margin: EdgeInsets.all(5),
                   decoration: BoxDecoration(color:Colors.white,  border: Border.all(color: delPack2Home?Colors.grey:Colors.black12) ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     mainAxisSize: MainAxisSize.max,
                     children: [
                       Checkbox(
                           value: delPack2Home,
                           onChanged:  onDelPack2HomeChanged
                       ),
                       Container(  height: 75,width: 75,
                           child:  Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             mainAxisSize: MainAxisSize.max,
                             children:[
                               Icon(Icons.grid_4x4),
                               Text("PakBox", style: TextStyle( color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 20)),
                             ],
                           )),
                       Icon(Icons.arrow_forward),
                       Container(  height: 75,width: 75,
                           child:  Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             mainAxisSize: MainAxisSize.max,
                             children:[
                               Icon(Icons.house),
                               Text("Dom", style: TextStyle( color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 20)),
                             ],
                           )),
                     ],
                   ),
                 ),),
                 Container( height:75, width: double.infinity,padding: EdgeInsets.all(0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     mainAxisSize: MainAxisSize.max,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text("ROZMIAR PRZESYŁKI", style: TextStyle(
                       color: Colors.grey[800],
                       fontWeight: FontWeight.normal,
                       fontSize: 20)),

                       SizedBox(width: 10,height: 10,),

                       RichText(
                         text: TextSpan(
                           children: [
                             TextSpan(
                               text: 'Jak spakować\npaczkę?',
                                recognizer: packInfoTapper,
                               style:   TextStyle(
                               color: Colors.black,
                               fontWeight: FontWeight.bold,
                               fontSize: 15)
                             ),
                           ],
                         ),
                       ),
                     Icon(Icons.arrow_forward),
                     ],
                   ),),
         Container(   width: double.infinity,padding: EdgeInsets.all(5),margin: EdgeInsets.all(5),
           child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               mainAxisSize: MainAxisSize.max,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Expanded( flex:1,
                   child: GestureDetector(
                   onTap: () {
                     packSizeSmallChanged(!packSizeSmall);
                   },
                    child:  Container(height:350, padding: EdgeInsets.all(5),margin: EdgeInsets.all(5),
                   decoration: BoxDecoration( color: Colors.white,border: Border.all(color: packSizeSmall?Colors.black:Colors.grey) ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     mainAxisSize: MainAxisSize.max,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text("Mała", style: TextStyle( color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 25)),
                       Icon(Icons.add_box,size:40),
                       Text("max.\n8x38x64\ncm\ndo 25 kg",textAlign: TextAlign.center, style: TextStyle( color: Colors.grey, fontWeight: FontWeight.normal,fontSize: 20)),
                       Text("${packSizeSmallVal}\nzł", textAlign: TextAlign.center, style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25)),
                       Checkbox(
                           value: packSizeSmall,
                           onChanged:  packSizeSmallChanged
                       ),
                     ],
                   ),
                 ),),),
                 Expanded( flex:1,
                   child:  GestureDetector(
                   onTap: () {
                     packSizeMedChanged(!packSizeMed);
                   },
                    child:  Container(height:350, padding: EdgeInsets.all(5),margin: EdgeInsets.all(5),
                   decoration: BoxDecoration(color: Colors.white, border: Border.all(color: packSizeMed?Colors.black:Colors.grey) ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     mainAxisSize: MainAxisSize.max,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text("Średnia", style: TextStyle( color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 25)),
                       Icon(Icons.add_box,size:50),
                       Text("max.\n19x38x64\ncm\ndo 25 kg",textAlign: TextAlign.center, style: TextStyle( color: Colors.grey, fontWeight: FontWeight.normal,fontSize: 20)),
                       Text("${packSizeMedVal}\nzł", textAlign: TextAlign.center, style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25)),
                       Checkbox(
                           value: packSizeMed,
                           onChanged:  packSizeMedChanged
                       ),
                     ],
                   ),
                 ),),),
                 Expanded( flex:1,
                 child: GestureDetector(
                   onTap: () {
                     packSizeBigChanged(!packSizeBig);
                   },
                   child:   Container(height:350, padding: EdgeInsets.all(5),margin: EdgeInsets.all(5),
                   decoration: BoxDecoration(color: Colors.white, border: Border.all(color: packSizeBig?Colors.black:Colors.grey) ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     mainAxisSize: MainAxisSize.max,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Text("Duża", style: TextStyle( color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 25)),
                       Icon(Icons.add_box,size:60),
                       Text("max.\n41x38x64\ncm\ndo 25 kg",textAlign: TextAlign.center, style: TextStyle( color: Colors.grey, fontWeight: FontWeight.normal,fontSize: 20)),
                       Text("${packSizeBigVal}\nzł", textAlign: TextAlign.center, style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25)),
                       Checkbox(
                           value: packSizeBig,
                           onChanged:  packSizeBigChanged
                       ),
                     ],
                   ),
                 ),),),


               ],
               ),
             ),
                 Container(color:Colors.white, height: 40,width: double.infinity,padding: EdgeInsets.all(0),margin: EdgeInsets.symmetric(horizontal: 20),
                   child:Text("Podstawowe ubezpieczenie do kwoty 5000 zł",textAlign: TextAlign.center, style: TextStyle(
                       color: Colors.grey[800],
                       fontWeight: FontWeight.normal,
                       fontSize: 15)),),
                 Container(  width: double.infinity, margin: EdgeInsets.all(20),
                   decoration: BoxDecoration( border: Border.all(color:  Colors.black) ),
                   child:   TextButton(
                   style:  TextButton.styleFrom(
                     minimumSize: Size(1500, 75),
                     backgroundColor: Colors.yellowAccent,
                     padding: EdgeInsets.all(0),

                   ),
                   child: Text( "Jak nadawać przesyłki", textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Colors.black87,
                       fontWeight: FontWeight.bold,
                       fontSize: 24), ),
                   onPressed: () {
                     sendInfoDialog(  context);
                   },
                 ),
                 )
                ]
               ),
             ),
             ),
           Expanded( flex:1, child:
           Container(color:Colors.white, width: double.infinity,
             padding: EdgeInsets.all(10),  margin: EdgeInsets.all(15),
               child:Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 mainAxisSize: MainAxisSize.max,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                 Expanded( flex:1, child:   Column(

                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     mainAxisSize: MainAxisSize.max,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Do zapłaty:", style: TextStyle(
                           color: Colors.grey[800],
                           fontWeight: FontWeight.normal,
                           fontSize: 25)),
                       Text("${sendPrice} zł",style: TextStyle(
                           color: Colors.grey[800],
                           fontWeight: FontWeight.bold,
                           fontSize: 30)),
                     ],

                 ),
                 ),
               Expanded( flex:1,
                  child:  TextButton(
                    style:  TextButton.styleFrom(
                      minimumSize: Size(1500, 75),
                      backgroundColor: Colors.yellowAccent,
                      padding: EdgeInsets.all(0),
                    ),
                    child: Text( "Dalej", style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 30), ),
                    onPressed: () {

                      },
                  )
               )
             ],

             )

           ),),


         ],
       ),
       ),
   );
  }

  }

