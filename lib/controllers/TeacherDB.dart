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

    try {
      this.dataMap = json.decode((await this.localData.readAsString()));
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
        profilePic: v['picture'],
        profileDescription: v['description'],
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
      if(v['name'].toLowerCase().contains(keyword.toLowerCase())) {
        NameCard card = NameCard(
          name: v['name'],
          profilePic: v['picture'],
          profileDescription: v['description'],
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
