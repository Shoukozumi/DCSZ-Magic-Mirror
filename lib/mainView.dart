import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'controllers/TeacherDB.dart';
import 'package:path_provider/path_provider.dart';

class mainView extends StatefulWidget {
  mainView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _mainViewState createState() => _mainViewState();
}

class _mainViewState extends State<mainView> {
  Widget colorList(Color color) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchFocus = FocusNode();

    loadData();
  }
  
  void loadData() async{
    // Loading bar while data is being loaded
    this.cardList = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting data...'),
            )
          ],
        ));

    this.localData = TeacherDB(context: context);
    await this.localData.initDB();
    setState(() {
      this.cardList = this.localData.initCards();
    });

//    await DefaultAssetBundle.of(context).loadString('data/data.json').then((jsondata) {
//      this.localData = TeacherDB(context: context);
//      this.cardList = this.localData.initCards();
//    });
//    setState(() => {});
  }

  FocusNode searchFocus;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchFocus.dispose();
    super.dispose();
  }

  Widget cardList;
  TeacherDB localData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Search for names...'),
                focusNode: searchFocus,
                onChanged: (keyword){
                  setState(() {
                    cardList = localData.searchTeacher(keyword);
                  });
                },
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  searchFocus.unfocus();
                },
                child: Container(child: cardList)
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Update"),
        icon: Icon(
          Icons.update,
          size: 30,
        ),
        onPressed: () async{
          print("${await getApplicationDocumentsDirectory()}");
        },
      ),
    );
  }
}


