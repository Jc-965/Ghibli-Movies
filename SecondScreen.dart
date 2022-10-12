import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

class MovieShower extends StatelessWidget {
  String searchQuery;
  MovieShower ({Key key, this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studio Ghibli',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Ghibli help page', search: searchQuery),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.search}) : super(key: key);
  String search;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future <Movie> _getMovies () async {
    //var data = await http.get(Uri.parse("https://ghibliapi.herokuapp.com/films/"));

    var data = await http.get(Uri.parse("https://ghibliapi.herokuapp.com/films/"));

    var jsonData = json.decode(data.body);

    // print(jsonData);
    print(jsonData[0]["title"]);
    print(jsonData[0]["original_title_romanised"]);
    print(jsonData[0]["image"]);
    print(jsonData[0]["description"]);
    print(jsonData[0]["release_date"]);
    print(jsonData[0]["running_time"]);
    print(jsonData[0]["rt_score"]);


    Movie newMovie = Movie(
        jsonData[0]["title"], //title
        jsonData[0]["original_title_romanised"], //original_title_romanised
        jsonData[0]["image"], //image
        jsonData[0]["description"], //description
        jsonData[0]["release_date"],//release_date
        jsonData[0]["running_time"], //running_time
        jsonData[0]["rt_score"], //rt_score
    );

    //   final String title;
    //   final String original_title_romanised;
    //   final String image;
    //   final String description;
    //   final String release_date;
    //   final String running_time;
    //   final String rt_score;
    print (widget.search);
    // print(newPokemon.name);
    // print(newPokemon.abilities);
    // print(newPokemon.Frontsprite);
    // print(newPokemon.height);
    // print(newPokemon.hp);
    // print(newPokemon.att);

    return newMovie;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: FutureBuilder(
            future: _getMovies(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  color: Color(0xff332ce7),
                  alignment: Alignment.center,
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else {
                return Container(
                  color: Color(0xff188cb6),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 25),
                  child: new Column(
                    children: [

                      new Container(
                        child: new Image.network (
                          snapshot.data.image,
                          width: 200.0,
                          height: 250.0,
                          fit: BoxFit.contain,
                        ),
                      ),

                      new Container(
                        child: new Text(
                          snapshot.data.title.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Aleo',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Colors.white),
                        ),
                      ),

                      new Container(
                        child: new Text(
                          snapshot.data.original_title_romanised,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Aleo',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0,
                              color: Colors.white),
                        ),
                      ),

                      new Container(
                        child: new Text(
                          "Release Date: " + snapshot.data.release_date,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Aleo',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                      ),

                      new Container(
                        child: new Text(
                          "Run Time: " + snapshot.data.running_time + " Minutes",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Aleo',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                      ),


                      new Container(
                        child: new Text(
                          "\n Rating: " + snapshot.data.rt_score,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Aleo',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                      ),

                      new Container(
                        child: new Text(
                          "Description: \n" + snapshot.data.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Aleo',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                              fontSize: 15.0,
                              color: Colors.white),
                        ),
                      ),




                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}

class Movie {
  final String title;
  final String original_title_romanised;
  final String image;
  final String description;
  final String release_date;
  final String running_time;
  final String rt_score;


  Movie (this.title, this.original_title_romanised, this.image, this.description, this.release_date, this.running_time, this.rt_score);
}

// "title": "Castle in the Sky"
// "original_title_romanised": "Tenkū no shiro Rapyuta"
// "image": "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg"
// "description": "..."
// "release_date": "1986"
// "running_time": "124"
//  "rt_score": "95"