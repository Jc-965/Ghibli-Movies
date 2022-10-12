import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'SecondScreen.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

//https://ghibliapi.herokuapp.com/#section/Workflow

//Guide to connect screens/send data:
// https://protocoderspoint.com/flutter-pass-data-between-screens/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: SecondScreen(),
      title: new Text(
        'Welcome To Video Editor', // name of app !!!!
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.asset(
        // will be edited !!!!
        'assets/img.png',
      ),
      backgroundColor: Color(0xa03687f5),
      photoSize: 200.0,
      loaderColor: Color.fromARGB(255, 205, 26, 224),
    );
    ;
  }
}

class SecondScreen extends StatelessWidget {
  var data;
  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/movies.json');
    data = json.decode(jsonText);
    print("hello");
    return 'success';
  }

  @override
  void initState() {
    //super.initState();
    this.loadJsonData();
    print(data);
    // Timer(
    //     Duration(seconds: 5),
    //         () => Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => SecondScreen())));
  }

  TextEditingController _searchQuery =
      TextEditingController(); //ADD THIS SECTION
  // List<Pair <String, String>> movieId;

  // var data = readJson();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Studio Ghibli")),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/img_1.png',
              width: 300.0,
              height: 350.0,
              fit: BoxFit.contain,
            ),

            //mainAxisAlignment: MainAxisAlignment.center,

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchQuery,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Enter your movie name"),
              ),
            ),
            ElevatedButton(
              child: const Text('`Search'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovieShower(searchQuery: _searchQuery.text)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
/*
Studio Ghibli logo: https://localist-images.azureedge.net/photos/39582076151907/square_300/9b1559a4ae89c0c7254e2b82227da5cc6f2e024e.jpg
*/
