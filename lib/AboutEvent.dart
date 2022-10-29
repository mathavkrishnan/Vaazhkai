import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AboutEvent extends StatelessWidget {
  late String name;
  late String place;
  DateTime? datep;
  late String descp;
  late var phno;
  AboutEvent(String name,String place,DateTime datep,String descp,var phno){
    this.name = name;
    this.datep = datep;
    this.place = place;
    this.descp = descp;
    this.phno = phno;
  }

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
                      textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)
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
            fixedColor: Colors.white,
            backgroundColor: Color(0xFF3F3F40),
          ),
        ),
        body: SizedBox(
          width: 460,
          child: Container(
              child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 60, 40, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: Color(0xF6C4C4C4),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 50,),
                                Text('$name',style: GoogleFonts.getFont('Acme',textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 40),)),
                                SizedBox(height: 10,),
                                Container(color: Color(0xFF3F3F40),child: Text("$datep",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                SizedBox(height: 10,),
                                Container(color: Color(0xFF3F3F40),child: Text("$place",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text("$descp",style: GoogleFonts.getFont('Acme',textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),)),
                                ),
                                SizedBox(height: 10,),
                                ElevatedButton(
                                  child: Text('Booknow', style: TextStyle(fontSize: 20.0),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                                  onPressed: () async {
                                    final Uri url = Uri.parse('https://vitchennaievents.com/technovit/');
                                    if (!await launchUrl(url)) {
                                      throw 'Could not launch $url';
                                    }
                                  }
                                ),
                                SizedBox(height: 5,),
                                FloatingActionButton(
                                  child: Text('call coordinator', style: TextStyle(fontSize: 20.0),),
                                  onPressed: () {
                                    launch("tel:+91$phno");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),)
                  ])
          ),
        )
    );
  }
}

