import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Buyandsell extends StatefulWidget {
  const Buyandsell({Key? key}) : super(key: key);

  @override
  _Buyandsell createState() => _Buyandsell();
}

class _Buyandsell extends State<Buyandsell> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getUsers();
  }
  List name = [];
  List desc = [];
  List img = [];
  num x = 0;
  final _firestore = FirebaseFirestore.instance;
  void getUsers() async {
    final messages= await _firestore.collection('buyorsell').get();
    for(var message in messages.docs){
      var usrMap = message.data();
      usrMap.forEach((k,v){
        if(k == "Name"){
          name.add(v);
        }
        else if(k == "Description"){
          desc.add(v);
        }
        else if(k == "Image"){
          img.add(v);
        }
      } );
    }
    x = name.length+counter-1;
    print(x);
    print(name);
  }
  int counter = 4;
  SwipeableCardSectionController _cardController = SwipeableCardSectionController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xFF3F3F40),Color(0xFF3F3F40)]),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(50), // Image radius
                  child: Image.asset('assets/images/title.png',width: 20,height: 20,),
                ),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              children: <Widget>[
                Text('by Vit Valzhkai',style: GoogleFonts.getFont(
                    "Bungee",
                    textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)
                ))
              ],
            )
          ],
        ),
      ),
      key: scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(64),
                            bottomRight: Radius.circular(64),
                          ),
                        ),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFFFD0E42),
                            Color(0xFFC30F31),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 700,
                      width: 340,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0, left: 20.0),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SwipeableCardsSection(
                                  cardController: _cardController,
                                  context: context,
                                  //add the first 3 cards
                                  items: [
                                    Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Image(
                                              image: NetworkImage("https://github.com/mathavkrishnan/mathavkrishnan.github.io/raw/main/job.jpg"),
                                              height: 350,
                                              width: 300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Image(
                                              image: NetworkImage("https://github.com/mathavkrishnan/mathavkrishnan.github.io/raw/main/up.jpg"),
                                              height: 350,
                                              width: 300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Card(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Image(
                                              image: NetworkImage("https://github.com/mathavkrishnan/mathavkrishnan.github.io/raw/main/down.jpg"),
                                              height: 350,
                                              width: 300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  onCardSwiped: (dir, index, widget) {
                                    //Add the next card
                                    if (counter <= x){
                                      _cardController.addItem(
                                        Card(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Image(
                                                  image: NetworkImage(img[index]),
                                                  height: 300,
                                                  width: 300,
                                                ),
                                              ),
                                              Text(name[index]),
                                              Text(desc[index]),
                                            ],
                                          ),
                                        ),
                                      );
                                      counter++;
                                    }
                                    if (dir == Direction.right) {
                                      print('onDisliked ${(widget as Card)} $index');
                                    } else if (dir == Direction.left) {
                                      print('onLiked ${(widget as Card)} $index');
                                    }
                                    else if (dir == Direction.up) {
                                      print('onLiked ${(widget as Card)} $index');
                                    }
                                    else if (dir == Direction.down) {
                                      print('onDisliked ${(widget as Card)} $index');
                                    }
                                  },
                                  enableSwipeUp: true,
                                  enableSwipeDown: true,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FloatingActionButton(
                                        child: Icon(Icons.phone),
                                        backgroundColor: Colors.red,
                                        onPressed: () {
                                          print("call");
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class Buyorsell {

  final String Name;
  final String Image;
  final String Description;

  const Buyorsell({
    required this.Name,
    required this.Image,
    required this.Description,
  });

  factory Buyorsell.fromMap(Map<dynamic, dynamic> map) {
    return Buyorsell(
      Name: map['Name'] ?? '',
      Image: map['Image'] ?? '',
      Description: map['Description'] ?? '',
    );
  }
}
