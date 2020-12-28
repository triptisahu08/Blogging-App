import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_app/screens/home.dart';
import 'package:splashscreen/splashscreen.dart';


void main() async{
  // async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
   await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:Splash2(),
    );
  }
}
class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      gradientBackground: LinearGradient(
        begin:Alignment.topRight,
        end: Alignment.bottomLeft,
          colors: [Colors.redAccent,Colors.black54]
      ),
      seconds: 5,
      navigateAfterSeconds: new HomePage(),
      title: new Text(
        'Every Blog is a Story.\n         \t Tell Yours',
        style: TextStyle(color: Colors.white70),
        textScaleFactor: 1,
      ),
      image: Image.asset('assets/blog1.png',width: 300,height: 100,),
      loadingText: Text("Blogging..."),
      photoSize: 100.0,
      loaderColor: Colors.redAccent,
    );
  }
}
