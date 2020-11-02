import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Cats> fetchCat() async {
  final response = await http.get('http://hers.hosts1.ma-cloud.nl/catabase/getcats.php');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Cats.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Cat');
  }
}

class Cats {

  final List<String> cats;

  Cats({
    this.cats,
  });

  factory Cats.fromJson(Map<String, dynamic> json) {

    var list = json['cats'] as List;
    print(list.runtimeType); // returns List<dynamic>

    List<Cat> catsList = list.map((i) =>
    Cat.fromJson(i)).toList();

    return Cats(
      // cats: catsList
    );
  }
}

class Cat{
  final String name;
  final String image;
  final String breed;
  final String gender;
  final String dob;
  final String added;

  Cat({
    this.name,
    this.image,
    this.breed,
    this.gender,
    this.dob,
    this.added
  });

  factory Cat.fromJson(Map<String, dynamic> json) {

    return Cat(
      name: json['name'],
      image: json['image'],
      breed: json['breed'],
      gender: json['gender'],
      dob: json['dob'],
      added: json['added'],
    );
  }
}


class ApiPage extends StatefulWidget {
  ApiPage( {Key key}) : super (key : key);

  @override
  _ApiPage createState() => _ApiPage();
}


class _ApiPage extends State<ApiPage> {
  Future<Cats> futureCat;

  @override
  void initState() {
    super.initState();
    futureCat = fetchCat();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Cats!"),
          backgroundColor: Colors.teal[400],
        ),
        body: Center(
          child: FutureBuilder<Cats>(
            future: futureCat,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.cats.length,
                    itemBuilder: (BuildContext context, int index) {
                      return
                        Card(

                        );
                  }
                  );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}



//  http://hers.hosts1.ma-cloud.nl/catabase/getcats.php