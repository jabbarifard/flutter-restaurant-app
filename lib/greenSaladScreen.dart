import 'dart:convert';

import 'package:flutter/material.dart';
import 'main.dart';


class GreenSaladScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Future<List<Widget>> createList() async {
      List<Widget> items = [];
      String dataString =
      await DefaultAssetBundle.of(context).loadString("assets/data.json");
      List<dynamic> dataJSON = jsonDecode(dataString);


      dataJSON.forEach((object) {
        if(object["foodType"] == "greenSalad") {
          object["foodItems"].forEach((item){
            items.add(Padding(padding: EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2.0,
                          blurRadius: 5.0
                      ),
                    ]
                ),
                margin: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(item["description"],style: TextStyle(fontSize: 18)),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                              // child: Text(finalString,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0,color: Colors.black54,),maxLines: 1,),
                            ),
                            Text("Price: ${item["price"]}", style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 18.0, color: Colors.black54),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),));
          });
        }
      });

      return items;
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Green Salads",style: TextStyle(fontSize:32, fontStyle:FontStyle.italic,fontWeight: FontWeight.bold)),
        toolbarHeight: 100,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                child: FutureBuilder(
                    initialData: <Widget>[Text("")],
                    future: createList(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: snapshot.data!,
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text("Back to Home Page", style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
              ),
            ]
        ),
      ),
    );
  }
}