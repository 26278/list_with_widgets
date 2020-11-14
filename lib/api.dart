import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatList extends StatelessWidget{

  final String apiUrl = "http://hers.hosts1.ma-cloud.nl/catabase/getcats.php";

  Future<List<dynamic>> fetchCats() async {

    var result = await http.get(apiUrl);
    return json.decode(result.body)['cats'];

  }

  String _name(dynamic cat){
    return cat['name'];

  }

  String _breed(dynamic cat){
    return cat['breed'];
  }

  // String _gender(Map<dynamic, dynamic> cat){
  //   if(cat['gender'] == 0){
  //     return "male";
  //   }
  //   else {
  //     return "female";
  //   }
  // }


  /// I take the current time so that I can calculate the age.
  /// I take the dob (date of birth) from the JSON array. that's a string.
  /// Then I change the dob string into a time datatype.
  /// I calculate the difference between now and the dob with the Duration difference function.
  /// I calculate the difference to years, but that int still has decimals
  /// I turn the years into a string and split the string at the dot.
  /// Then I only choose the first int before the dot,
  /// so that's basically the amount of years as how we humans see it.
  /// Then I return the string with the text Age: x years
  String _age(Map<dynamic, dynamic> cat){
    var now = new DateTime.now();
    var bornString = cat['dob'];
    // print('The value of this is: $bornString');

    var born = DateTime.parse(bornString);
    Duration difference = now.difference(born);
    var years = difference.inDays / 365;
    // print(The value of this is $years);

    var age = years.toString().split('.')[0];
    var ageString = 'Age: $age years';

    return ageString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat List'),
        backgroundColor: Colors.teal[400],
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchCats(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              // print(_age(snapshot.data[0]));
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return
                      Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(snapshot.data[index]['image'])),
                              title: Text(_name(snapshot.data[index])),
                              subtitle: Text(_breed(snapshot.data[index])),
                              trailing: Text(_age(snapshot.data[index])),
                            )
                          ],
                        ),
                      );
                  });
            }else {
              return Center(child: CircularProgressIndicator());
            }
          },


        ),
      ),
    );
  }

}