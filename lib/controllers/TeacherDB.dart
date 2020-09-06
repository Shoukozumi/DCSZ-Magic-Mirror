import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:studentapp/main.dart';
import 'package:studentapp/widgets/NameCard.dart';
import 'package:studentapp/widgets/CardHolder.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class TeacherDB{
  BuildContext context;

  Map dataMap;
  Map resourceMap;

  File localData;
  File localResource;

  TeacherDB({this.context});

  initDB() async {
    // getting the local file path
    String localPath = (await getApplicationDocumentsDirectory()).path;

    // establishing file connection
    this.localData = File("$localPath/data.json");
      //await this.localData.delete();
    this.localResource = File("$localPath/resources.json");


    if(!await this.localData.exists())
      this.localData.writeAsString(await DefaultAssetBundle.of(context).loadString('data/data.json'));
      print("default data written to disk");

    if(!await this.localResource.exists())
      this.localResource.writeAsString(await DefaultAssetBundle.of(context).loadString('data/resource.json'));
    print("default resource written to disk");

    try {
      this.dataMap = json.decode((await this.localData.readAsString()));
      this.resourceMap = json.decode(await this.localResource.readAsString());
    } catch (e){
      print("Error occured! \n$e");
    }
  }

  Widget initCards(){
    var cards = <Widget>[];

    NameCard tmp;
    bool flag = false;

    dataMap.forEach((key, v){ //v for value
      NameCard card = NameCard(
        name: v['name'],
        profilePic: this.resourceMap[key],
        profileDescription: v['description'],
        school: v['school'],
        position: v['position'],

        context: context,
      );

      if(flag){
        CardHolder holder = CardHolder(
          cardA: tmp,
          cardB: card,
        );
        cards.add(holder.build());
        flag = false;
      }else{
        tmp = card;
        flag = true;
      }
    });
    if(flag){
      CardHolder holder = CardHolder(
        cardA: tmp,
      );
      cards.add(holder.build(isSingle: true));
    }

    return ListView(
        padding: const EdgeInsets.all(8),
        children: cards,
    );
  }

  searchTeacher(String keyword){
    var cards = <Widget>[];

    NameCard tmp;
    bool flag = false;

    dataMap.forEach((key, v){ //v for value
      String lowerCaseSearch = keyword.toLowerCase();
      String name = v['name'];
      String profileDescription = v['description'];
      String school = v['school'];
      String position = v['position'];
      
      if(name.toLowerCase().contains(lowerCaseSearch) || position.toLowerCase().contains(lowerCaseSearch) || school.toLowerCase().contains(lowerCaseSearch)) {
        NameCard card = NameCard(
          name: name,
          profilePic: this.resourceMap[key],
          profileDescription: profileDescription,
          school: school,
          position: position,

          context: context,
        );

        if (flag) {
          CardHolder holder = CardHolder(
            cardA: tmp,
            cardB: card,
          );
          cards.add(holder.build());
          flag = false;
        } else {
          tmp = card;
          flag = true;
        }
      }
    });
    if(flag){
      CardHolder holder = CardHolder(
        cardA: tmp,
      );
      cards.add(holder.build(isSingle: true));
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: cards,
    );
  }

  updateList() async{

  }
}
