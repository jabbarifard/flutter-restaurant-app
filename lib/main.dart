import 'package:flutter/material.dart';
import 'package:my_restaurant/quicheScreen.dart';
import 'package:my_restaurant/sandwichScreen.dart';
import 'package:my_restaurant/soup&saladScreen.dart';
import 'package:my_restaurant/tacoScreen.dart';
import 'package:my_restaurant/fajitaScreen.dart';
import 'appetizerScreen.dart';
import 'enchiladaScreen.dart';
import 'entreeScreen.dart';
import 'greenSaladScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

var bannerItems = ["Appetizers","Entrees","Sandwiches","Soup & Salad","Fajitas",
  "Tacos","Enchiladas","Quiches","Green Salads"];
var bannerImage = [
  "images/appetizer.jpg",
  "images/entrees.jpg",
  "images/sandwich.jpg",
  "images/soup&salad.jpg",
  "images/fajitas.jpg",
  "images/tacos.jpg",
  "images/enchilada.jpg",
  "images/quiche.jpg",
  "images/green-salad.jpg"
];

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading:Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: IconButton(icon:const Icon(Icons.menu),onPressed:(){}),
        ),
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top:8.0),
          child: Text("Restaurant Menu",
              style: TextStyle(fontStyle:FontStyle.italic,fontSize: 32, fontWeight: FontWeight.bold)),
        ),
      ),
      body:  Center(
        child: Column(
          children:
          <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 60.0, bottom: 60),
              child: BannerWidgetArea(),
            ),
            Text(
              'Welcome to our restaurant!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),

            Padding(
              padding: const EdgeInsets.only(top:54.0, left: 80, right: 80),
              child: Text(
                "Choose your food and enjoy the discount",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class BannerWidgetArea extends StatelessWidget {

  List<Widget> bannerRouts = [Container(child: AppetizerScreen()),Container(child: EntreeScreen()),
  Container(child: SandwichScreen()),Container(child: SoupSaladScreen()), Container(child: FajitaScreen()),
    Container(child: TacoScreen()), Container(child: EnchiladaScreen()),Container(child: QuicheScreen()),
    Container(child: GreenSaladScreen())];
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    PageController controller =
    PageController(viewportFraction: 0.8, initialPage: 1);

    List<Widget> banners = [];

    for (int x = 0; x < bannerItems.length; x++) {
      var bannerView = Padding(
        padding: EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => bannerRouts[x]),
            );
          },
          child: Container(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 5.0,
                            spreadRadius: 1.0)
                      ]),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: Image.asset(
                    bannerImage[x],
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black])),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        bannerItems[x],
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                      Text(
                        "More than 40% Off",
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
      banners.add(bannerView);
    }

    return SizedBox(
      width: screenWidth,
      height: screenWidth * 9 / 16,
      child: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: banners,
      ),
    );
  }
}

