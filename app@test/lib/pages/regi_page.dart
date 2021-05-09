import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projet_test/utils/color.dart';
import 'package:projet_test/pages/login_page.dart';
import 'package:projet_test/widgets/btn_widget.dart';
import 'package:projet_test/widgets/herder_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projet_test/pages/home_page.dart';
import 'package:http/http.dart' as http;

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Inscription", 0.4, false),
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
                        controller: lastNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Nom et Prénom",
                          prefixIcon: Icon(Icons.person),
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
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                            btnText: _isLoading
                                ? 'Enregistrement...'
                                : "S'enregistrer",
                            onClick: _isLoading ? null : _handleLogin
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
                                  builder: (context) => LoginPage()));
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Avez vous un compte ? ",
                              style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.none),
                            ),
                            TextSpan(
                                text: "S'identifier",
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

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    var url = 'https://rocky-coast-87478.herokuapp.com/api/user/register';
    var res = await http.post(Uri.parse(url), body: {
      'name': lastNameController.text,
      'email': mailController.text,
      'password': passwordController.text,
    });

    var body = json.decode(res.body);
    print(body);

    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', jsonEncode(body['user']));

      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    }

    setState(() {
      _isLoading = false;
    });
  }
}
