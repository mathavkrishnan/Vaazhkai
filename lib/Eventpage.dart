import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaazhkai/AboutEvent.dart';
class Eventpage extends StatefulWidget {
  const Eventpage({Key? key}) : super(key: key);

  @override
  State<Eventpage> createState() => _EventpageState();
}

class _EventpageState extends State<Eventpage> {
  @override
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
                child: Text("Upcoming events",style: GoogleFonts.getFont('Bungee',textStyle:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),)),),
              Padding(padding: EdgeInsets.all(10),
                child:StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('events').orderBy("Date").snapshots(),
                  builder: (context,snapshot){
                    List<Padding> evnt = [];
                    final events = snapshot.requireData.docs;
                    if(snapshot.hasData){
                      for(var i in events){
                        final String name = i.get('Name');
                        final String place = i.get('Place');
                        final phno = i.get('PNumber');
                        final datep = i.get('Date');
                        DateTime dateNo = datep.toDate();
                        final DateFormat formatter = DateFormat('dd-mm-yy @ hh-mm');
                        final String dateNow = formatter.format(dateNo);
                        final now = DateTime.now();
                        final bool isExpired = dateNo.isBefore(now);
                        final String descp = i.get('Description');
                        final dummy = Padding(padding: EdgeInsets.all(5),child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xF6C4C4C4),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(0, 20),
                                  blurRadius: 3,
                                  spreadRadius: -15)
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: <Widget>[
                                Text('$name',style: GoogleFonts.getFont('Acme',textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                SizedBox(height: 5,),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                      color: Color(0xFF3F3F40),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text('$dateNow',style: TextStyle(color: Colors.white,fontSize: 15),),
                                      )),
                                ),
                                SizedBox(height: 5,),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                      color: Color(0xFF3F3F40),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text('$place',style: TextStyle(color: Colors.white,fontSize: 15),),
                                      )),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 30,
                                  width: 30,
                                  color: Color(0xFF3F3F40),
                                  child: IconButton(
                                      onPressed: () async{
                                        await Navigator.push(context,MaterialPageRoute(builder: (context) =>AboutEvent(name,place,dateNo,descp,phno),));
                                      }, icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 15,)),
                                ),
                              ],
                            ),
                          ),),);
                        if(!isExpired){
                          evnt.add(dummy);
                        }
                      }
                      if(evnt.isEmpty){
                        evnt.add(
                            Padding(
                                padding: EdgeInsets.all(8),
                                child:Text("No events there to display"),
                            ));
                      }
                    }
                    return Column(
                      children: [
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: evnt,
                        )
                      ],
                    );
                  },
                ),
                ),
            ],
          ),
        )
      ),
    );
  }
}


