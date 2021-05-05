import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutorial_project/pages/regi_page.dart';
import 'package:tutorial_project/utils/color.dart';
import 'package:tutorial_project/widgets/btn_widget.dart';
import 'package:tutorial_project/widgets/herder_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_project/api/api.dart';
import 'package:tutorial_project/Home/homeScreen.dart';
import 'package:tutorial_project/pages/publication_page.dart';
import 'package:http/http.dart' as http;

class CreatePublication extends StatefulWidget {
  @override
  _CreatePublicationState createState() => _CreatePublicationState();
}

class _CreatePublicationState extends State<CreatePublication> {
  bool _isLoading = false;
  TextEditingController titreController = TextEditingController();
  TextEditingController contenuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Nouvelle Publication", 0.2, true),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: titreController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Titre",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Le contenu'),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 5,
                        maxLines: 5,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      //child: Text("Forgot Password?"),
                    ),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          btnText: _isLoading ? "Publication..." : "Pubblier",
                          onClick: _isLoading ? null : _handleInsertPublication,
                          //onClick: (){Navigator.pop(context); },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PublicationPage()));
        },
        child: const Icon(Icons.list),
        backgroundColor: orangeColors,
      ),
    );
  }

  void _handleInsertPublication() async {
    setState(() {
      _isLoading = true;
    });

    var url = 'https://rocky-coast-87478.herokuapp.com/api/publication/store';
    var response = await http.post(url, body: {
      'titre': titreController.text,
      'contenu': contenuController.text,
    });

    var body = json.decode(response.body);

    if (body['success']) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => PublicationPage()));
    }

    setState(() {
      _isLoading = false;
    });
  }
}
