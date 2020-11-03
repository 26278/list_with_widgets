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

  String _gender(Map<dynamic, dynamic> cat){
    if(cat['gender'] == 0){
      return "male";
    }
    else {
      return "female";
    }
  }

  String _age(Map<dynamic, dynamic> cat){
    var now = new DateTime.now();
    var born = cat['age'];
    Duration difference = now.difference(born);
    var years = difference.inDays / 365;
    print(years);
    var age = toString(years);

    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
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