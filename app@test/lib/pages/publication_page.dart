import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_project/EditProfile/editProfileScreen.dart';
import 'package:tutorial_project/Login/loginScreen.dart';
import 'package:tutorial_project/api/api.dart';
import 'package:tutorial_project/utils/color.dart';
import 'package:tutorial_project/widgets/herder_container.dart';
import 'package:tutorial_project/pages/create_publication.dart';
import 'package:tutorial_project/pages/details_publication.dart';

class PublicationPage extends StatefulWidget {
  @override
  _PublicationPageState createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  Future getData() async {
    var url = 'https://rocky-coast-87478.herokuapp.com/api/publication/';
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreatePublication()));
          },
          child: const Icon(Icons.add),
          backgroundColor: orangeColors,
        ),
        body: Container(
            padding: EdgeInsets.only(bottom: 30),
            child: Column(children: <Widget>[
              HeaderContainer("Liste des publications", 0.1, true),
              Expanded(
                flex: 1,
                child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListView.separated(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              List list = snapshot.data;
                              return ListTile(
                                title: Text(list[index]['titre']),
                                subtitle: Text(list[index]['name']),
                                trailing: GestureDetector(
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    color: Color(0xffF5591F),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsPublication(
                                          list[index]['name'],
                                          list[index]['titre'],
                                          list[index]['contenu'],
                                          list[index]['created_at'],
                                        ),
                                      ),
                                    );
                                    debugPrint('Edit Clicked');
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: Color(0xffF5591F),
                              );
                            })
                        : CircularProgressIndicator();
                  },
                ),
              )
            ])));
  }
}
