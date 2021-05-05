import 'package:flutter/material.dart';
import 'package:tutorial_project/utils/color.dart';
import 'package:tutorial_project/pages/login_page.dart';
import 'package:tutorial_project/pages/home_page.dart';

class HeaderContainer extends StatelessWidget {
  var text = "Login", taille = 0.4, profil=false;

  HeaderContainer(this.text, this.taille,this.profil);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * taille,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [orangeColors, orangeLightColors],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => profil ?  HomePage() : LoginPage(),
                    ));
              },
              child: Icon(
                profil ? Icons.account_circle : Icons.vpn_key,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
          Center(
            child: Image.asset("assets/logo.png"),
          ),
        ],
      ),
    );
  }
}

