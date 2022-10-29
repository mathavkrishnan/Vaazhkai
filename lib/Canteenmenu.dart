import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class Canteenmenu extends StatefulWidget {
  const Canteenmenu({Key? key}) : super(key: key);

  @override
  State<Canteenmenu> createState() => _Canteenmenu();
}

class _Canteenmenu extends State<Canteenmenu> {
  @override
  List<Widget> dyn = [];
  String dropdownvalue = 'Hostel menu';
  var items = [
    'Hostel menu',
    'Vit shops',
    'Outside shops',
  ];
  final _firestore = FirebaseFirestore.instance;
  void initState(){
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
        }
      },
    );
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          // LocalNotificationService.display(message);

        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home,color: Colors.white,),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person,color: Colors.white,),
                  label: '',
                ),
              ],
              fixedColor: Colors.black,
              backgroundColor: Color(0xFF3F3F40),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Select Mess type",style: GoogleFonts.getFont('Bungee',textStyle:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 20,
                    elevation: 20,
                    style: TextStyle(color: Colors.grey,fontSize: 20,wordSpacing: 10),
                    underline: Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                        if(newValue == "Hostel menu"){
                          dyn.clear();
                          dyn.add(buttons1);
                        }
                        else if(newValue == "Vit shops"){
                          dyn.clear();
                          dyn.add(buttons2);
                        }
                        else if(newValue == "Outside shops"){
                          dyn.clear();
                          dyn.add(buttons3);
                        }
                      });
                    },
                  ),
                ),
                Column(
                  children: dyn,
                ),
              ],
            ),
          )
      ),
    );
  }
}

Widget buttons1 = Column(
  children: [
    ElevatedButton(onPressed: () {

    },
    child: Text("Non veg mess"),),
    ElevatedButton(onPressed: () {  },
      child: Text("Veg mess"),),
    ElevatedButton(onPressed: () {  },
      child: Text("Special mess"),),
  ],
);

Widget buttons2 = Column(
  children: [
    ElevatedButton(onPressed: () {  },
      child: Text("Georgia"),),
  ],
);

Widget buttons3 = Column(
  children: [
    ElevatedButton(onPressed: () {  },
      child: Text("Ambrocios biriyani"),),
  ],
);

