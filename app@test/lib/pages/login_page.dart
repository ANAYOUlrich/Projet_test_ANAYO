import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutorial_project/pages/regi_page.dart';
import 'package:tutorial_project/utils/color.dart';
import 'package:tutorial_project/widgets/btn_widget.dart';
import 'package:tutorial_project/widgets/herder_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_project/api/api.dart';
import 'package:tutorial_project/Home/homeScreen.dart';
import 'package:tutorial_project/pages/home_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("S'identifier", 0.4, false),
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
                      child: TextFormField(
                        controller: mailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          prefixIcon: Icon(Icons.call),
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
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          prefixIcon: Icon(Icons.vpn_key),
                        ),
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
                          btnText: _isLoading
                              ? "Identification ..."
                              : "S'identifier",
                          onClick: _isLoading ? null : _login,
                          //onClick: (){Navigator.pop(context); },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => RegPage(),
                              ));
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Vous n'avez pas de compte ? ",
                                style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.none)),
                            TextSpan(
                                text: "Enregistrer vous",
                                style: TextStyle(
                                    color: orangeColors,
                                    decoration: TextDecoration.none)),
                          ]),
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
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'email': mailController.text,
      'password': passwordController.text
    };

    var url = 'https://rocky-coast-87478.herokuapp.com/api/login';
    var res = await http.post(url, body: {
      'email': mailController.text,
      'password': passwordController.text
    });

    print(res.body);
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', jsonEncode(body['user']));
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
