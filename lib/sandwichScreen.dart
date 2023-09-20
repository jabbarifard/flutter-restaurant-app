import 'dart:convert';

import 'package:flutter/material.dart';
import 'main.dart';


class SandwichScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    sandwichList(String foodType, List<Widget> items, dynamic object){
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
                        if(item["price"] != "") Text("Price: ${item["price"]}", style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18.0, color: Colors.black54),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),));
      });
    };

    Future<List<Widget>> createList(String foodType) async {
      List<Widget> items = [];
      String dataString =
      await DefaultAssetBundle.of(context).loadString("assets/data.json");
      List<dynamic> dataJSON = jsonDecode(dataString);


      dataJSON.forEach((object) {
        if(object["foodType"] == foodType) {
          if(foodType == "coldSandwich") {
            sandwichList(foodType, items, object);
          } else {
            sandwichList(foodType,items,object);
          }
        }
      });

      return items;
    }

    String extraDescription1 = "* Served with Choices of House Pasta Salad, Green Salad, or Fresh Fruit. For additional \$1.50.";
    String extraDescription2 = "* You can 'upgrade' (by substituting) to 1/2 pasta salad of the day, French onion soup or soup of the day.";
    String extraDescription3 = "* Choice of sourdough, whole wheat, or rye bread";
    String extraDescription4 = "* half sandwich   \$7.95";
    String extraDescription5 = "* full sandwich   \$9.25";
    String extraDescription7 = "* Choice of whole wheat or cheese & onion bun";


    return Scaffold(
      appBar: AppBar(
        title: const Text("Sandwiches",style: TextStyle(fontSize:32, fontStyle:FontStyle.italic,fontWeight: FontWeight.bold)),
        toolbarHeight: 100,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:20, right:20, bottom:20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(extraDescription1, style: TextStyle(fontSize: 16)),
                    Text(extraDescription2, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Text("Cold Sandwiches",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0,color: Colors.black54,)),
              Padding(
                padding: const EdgeInsets.only(left:20, right:20, top:8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(extraDescription3, style: TextStyle(fontSize: 16)),
                    Text(extraDescription4, style: TextStyle(fontSize: 16)),
                    Text(extraDescription5, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Container(
                child: FutureBuilder(
                    initialData: <Widget>[Text("")],
                    future: createList("coldSandwich"),
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
              Text("Hot Sandwiches",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0,color: Colors.black54,)),
              Padding(
                padding: const EdgeInsets.only(left:20, right:20, top:8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(extraDescription7, style: TextStyle(fontSize: 16))
                  ],
                ),
              ),
              Container(
                child: FutureBuilder(
                    initialData: <Widget>[Text("")],
                    future: createList("hotSandwich"),
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