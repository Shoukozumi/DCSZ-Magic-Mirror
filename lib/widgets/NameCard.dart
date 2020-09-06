import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:studentapp/constants.dart';

class NameCard {
  String name;
  String profilePic;
  String profileDescription;
  String school;
  String position;
  BuildContext context;

  NameCard(
      {this.name,
      this.profilePic,
      this.profileDescription,
      this.school,
      this.position,
      this.context});

  Widget build() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Color(0xFF111328),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: EdgeInsets.all(8.0),
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
                    image: MemoryImage(base64.decode(this.profilePic)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FittedBox(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Roboto",
                  ),
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
                image: MemoryImage(base64.decode(this.profilePic)),
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: 10,
        ),
        FittedBox(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 40,
              fontFamily: ".SF UI Display",
            ),
          ),
        ),
        FittedBox(
          child: Text(
            position,
            style: kSubtext,
          ),
        ),
        Text(
          school.replaceAll(",", ", "),
          style: kSubtext,
        ),
        SizedBox(
          height: 10,
        ),
        Divider(color: Colors.white,),
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
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return getInfo();
        });
  }

  void updateDB() async {}
}
