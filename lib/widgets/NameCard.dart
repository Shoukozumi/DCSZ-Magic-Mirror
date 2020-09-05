import 'package:flutter/material.dart';
import 'dart:io';

class NameCard {
  String name;
  String profilePic;
  String profileDescription;
  BuildContext context;

  NameCard({this.name, this.profilePic, this.profileDescription, this.context});

  Widget build() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Color(0xFF111328),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
            child: GestureDetector(
          onTap: showInfo,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        'data/picture/$profilePic',
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Roboto",
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget getInfo() {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Column(children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  'data/picture/$profilePic',
                ),
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 40,
            fontFamily: ".SF UI Display",
          ),
        ),
        Divider(),
      ]),
      children: <Widget>[
        Text(
          "${profileDescription == 'none' ? 'This person forgot to write a description!' : profileDescription}",
          style: TextStyle(fontSize: 20, fontFamily: ".SF UI Text"),
        ),
      ],
      backgroundColor: Color(0xFF1D1E33),
    );
  }

  void showInfo() async {
    print(context);
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return getInfo();
        });
  }

  void updateDB() async {
    
  }
}
