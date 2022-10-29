import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaazhkai/Academic.dart';
import 'package:vaazhkai/Buyandsell.dart';
import 'package:vaazhkai/CGPA.dart';
import 'package:vaazhkai/Eventpage.dart';
import 'package:vaazhkai/Faculty.dart';
import 'package:vaazhkai/Maps.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vaazhkai/Canteenmenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePage();
}
class _HomePage extends State<HomePage> {
  @override
  Position? position;
  void location() async{
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
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
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 40.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.settings,color: Colors.black,size: 30,
                    ),
                  )
              ),
            ],
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
                  child: Text("Services",style: GoogleFonts.getFont('Bungee',textStyle:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),)),),
                Padding(padding: EdgeInsets.all(10),
                  child:Column(
                    children: [
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: <Widget>[

                          Padding(
                            padding: EdgeInsets.all(5),child: Container(
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
                                  Text('Events',style: GoogleFonts.getFont('Acme',textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                  SizedBox(height: 5,),
                                  Image.asset('assets/images/flat.png',width: 80,height: 80,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    color: Color(0xFF3F3F40),
                                    child: IconButton(
                                        onPressed: () async{
                                          await Navigator.push(context,MaterialPageRoute(builder: (context) =>Eventpage(),));
                                          }, icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 15,)),
                                  ),
                                ],
                      ),
                    ),),),
                          Padding(
                            padding: EdgeInsets.all(5),child: Container(
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
                                  Text('Canteen menu',style: GoogleFonts.getFont('Acme',textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                  SizedBox(height: 5,),
                                  Image.asset('assets/images/burger.png',width: 80,height: 80,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    color: Color(0xFF3F3F40),
                                    child: IconButton(
                                        onPressed: () async{
                                          await Navigator.push(context,MaterialPageRoute(builder: (context) =>Canteenmenu(),));
                                        }, icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 15,)),
                                  ),
                                ],
                              ),
                            ),),),
                          Padding(
                            padding: EdgeInsets.all(5),child: Container(
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
                                  Text('Faculty details',style: GoogleFonts.getFont('Acme',textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                  SizedBox(height: 5,),
                                  Image.asset('assets/images/call_center.png',width: 80,height: 80,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    color: Color(0xFF3F3F40),
                                    child: IconButton(
                                        onPressed: () async{
                                          await Navigator.push(context,MaterialPageRoute(builder: (context) =>Faculty(),));
                                        }, icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 15,)),
                                  ),
                                ],
                              ),
                            ),),),
                          Padding(
                            padding: EdgeInsets.all(5),child: Container(
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
                                  Text('Academic calender',style: GoogleFonts.getFont('Acme',textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                  SizedBox(height: 5,),
                                  Image.asset('assets/images/calendar.png',width: 80,height: 80,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    color: Color(0xFF3F3F40),
                                    child: IconButton(
                                        onPressed: () async{
                                          await Navigator.push(context,MaterialPageRoute(builder: (context) =>Academic(),));
                                        }, icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 15,)),
                                  ),
                                ],
                              ),
                            ),),),
                          Padding(
                            padding: EdgeInsets.all(5),child: Container(
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
                                  Text('Vit Map',style: GoogleFonts.getFont('Acme',textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                  SizedBox(height: 5,),
                                  Image.asset('assets/images/location.png',width: 80,height: 80,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    color: Color(0xFF3F3F40),
                                    child: IconButton(
                                        onPressed: () async{
                                          location();
                                          await Navigator.push(context,MaterialPageRoute(builder: (context) =>Maps(),));
                                        }, icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 15,)),
                                  ),
                                ],
                              ),
                            ),),),
                          Padding(
                            padding: EdgeInsets.all(5),child: Container(
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
                                  Text('CGPA calculator',style: GoogleFonts.getFont('Acme',textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                  SizedBox(height: 5,),
                                  Image.asset('assets/images/rule.png',width: 80,height: 80,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    color: Color(0xFF3F3F40),
                                    child: IconButton(
                                        onPressed: () async{
                                          await Navigator.push(context,MaterialPageRoute(builder: (context) =>CGPA(),));
                                        }, icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 15,)),
                                  ),
                                ],
                              ),
                            ),),),
                          Padding(
                            padding: EdgeInsets.all(5),child: Container(
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
                                  Text('Buy',style: GoogleFonts.getFont('Acme',textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                  SizedBox(height: 5,),
                                  Image.asset('assets/images/money.png',width: 80,height: 80,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    color: Color(0xFF3F3F40),
                                    child: IconButton(
                                        onPressed: () async{
                                          await Navigator.push(context,MaterialPageRoute(builder: (context) =>Buyandsell(),));
                                        }, icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 15,)),
                                  ),
                                ],
                              ),
                            ),),),
                          Padding(
                            padding: EdgeInsets.all(5),child: Container(
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
                                  Text('Sell',style: GoogleFonts.getFont('Acme',textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                  SizedBox(height: 5,),
                                  Image.asset('assets/images/money.png',width: 80,height: 80,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    color: Color(0xFF3F3F40),
                                    child: IconButton(
                                        onPressed: () async {
                                          final Uri url = Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSdAXTRzEAR_MVKApeuw-5KdgnFCnatO7VHlb-B-SEAk-3E3BQ/viewform?usp=sf_link');
                                          if (!await launchUrl(url)) {
                                            throw 'Could not launch $url';
                                          }
                                        }, icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 15,)),
                                  ),
                                ],
                              ),
                            ),),),
                          Padding(
                            padding: EdgeInsets.all(5),child: Container(
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
                                  Text('ChatBot',style: GoogleFonts.getFont('Acme',textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
                                  SizedBox(height: 5,),
                                  Image.asset('assets/images/robot.png',width: 80,height: 80,),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    color: Color(0xFF3F3F40),
                                    child: IconButton(
                                        onPressed: () async{
                                          await Navigator.push(context,MaterialPageRoute(builder: (context) =>Eventpage(),));
                                        }, icon: Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 15,)),
                                  ),
                                ],
                              ),
                            ),),),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}


