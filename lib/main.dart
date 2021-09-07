// @dart=2.9
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import '/MyHomePage.dart';
import 'package:flutter/gestures.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
/*
void main() {
  runApp(MyApp());
}
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
      await FirebaseAuth.instance.currentUser != null

  ));
}

class MyApp extends StatelessWidget {

  MyApp(this.isSignedIn);

  final bool isSignedIn;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pack manager',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyLoginPage( ),
    //  home: MyHomePage(title: 'Pack manager'),
    );
  }
}

class MyLoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return MyLoginPageState();

  }

}

class MyLoginPageState extends State<MyLoginPage>{

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  User _user;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _verificationComplete = false;
  bool _saving = false;

  MyLoginPageState() {
    _emailController.text = "aaa@aaa.pl";
    _passwordController.text = "aaaaaa";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
         child:
       Stack(
        fit:StackFit.expand,
        children:<Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 100),
              Form(
                child:Theme(
                    data: ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: Colors.teal,
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(color:Colors.teal,fontSize: 20)
                      ),
                    ),
                  child: Container(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration:InputDecoration(labelText: "Wpisz email") ,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                        ),
                        TextFormField(
                          decoration:InputDecoration(labelText: "Wpisz hasło") ,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: _passwordController,
                        ),
                        Padding(padding: EdgeInsets.only(top:40),),
                        MaterialButton(
                          height: 40,
                            minWidth: 100,
                          color:Colors.teal,
                          textColor: Colors.white,
                          child:Text("Login", style: TextStyle(fontSize: 20),),
                          onPressed: (){
                          //Modal progress overlay
                           // showLoaderDialog(context);
                            setState(() {
                              _saving = true;
                            });

                            logIn(
                                _emailController.text,
                                _passwordController.text
                            ).then(
                                    (user) {
                                  _user = user;
                                 /// if(!_user.emailVerified) {
                                  ///  _user.sendEmailVerification();
                                 /// }
                                  //Modal progress overlay
                                  //Navigator.pop(context);

                                  _verificationComplete = true;
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                      builder: (context) => MyHomePage(title: 'Pack manager')
                                  )
                                  );
                                }
                            ).catchError(
                                    (e) {
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "You don't have an account. Please sign up."
                                          )
                                      )
                                  );
                                }
                            );


                          },
                          splashColor: Colors.cyanAccent,
                        ),
                        Padding(padding: EdgeInsets.only(top:40),),
                        _buildSignupBtn(context),
                      ],
                    )
                  ),
                    ),

              ),

            ],

          )

        ]

      ),
      ),

    );
  }

  Widget _buildSignupBtn(BuildContext context) {
    TapGestureRecognizer _tapGestureRecognizer=TapGestureRecognizer();
    _tapGestureRecognizer.onTap=() async {
      try {
        _user = await signUp(
            _emailController.text,
            _passwordController.text,
            context
        );
       /* if (!_user.emailVerified) {
          _user.sendEmailVerification();
        }*/
        _verificationComplete = true;
        Navigator.pushReplacement(
            context, MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Pack manager')
        )
        );
      }
      catch (e) {
        Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Text("An error occurred")
            )
        );
      }
    };

    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Nie masz konta? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Rejestracja',
              recognizer: _tapGestureRecognizer,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<User> signUp(
      String email, String password, BuildContext context
      ) async{
    print("TEST1 "+email+" "+password);
    UserCredential authResult;
    try {
      authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    }
    catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(e.toString())
        ),
      );
      print("eoor="+e.toString());
    }

    print("TEST2");
    return authResult.user;
  }

  Future<User> logIn(String email, String password) async
  {
    UserCredential authResult = await _auth
        .signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return authResult.user;
  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

}