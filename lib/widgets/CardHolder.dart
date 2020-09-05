import 'NameCard.dart';
import 'package:flutter/material.dart';

class CardHolder{
  NameCard cardA;
  NameCard cardB;

  CardHolder({this.cardA, this.cardB});

  Widget build({bool isSingle = false}){
    if(isSingle){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: cardA.build(),),
          Expanded(child: Container(),),
        ],
      );
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: cardA.build(),),
          Expanded(child: cardB.build(),),

        ],
    );
  }
}