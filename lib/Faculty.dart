import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Faculty extends StatefulWidget {
  const Faculty({Key? key}) : super(key: key);

  @override
  State<Faculty> createState() => _Faculty();
}

class _Faculty extends State<Faculty> {
  @override
  String query = ' ';
  var items;
  List<Fac>? allfac;
  late List<Fac> getus;
  void main() async{
    allfac = await getUsers();
    getus = await getUsers();
  }
  void initState(){
    super.initState();
    main();
  }
  static Future<List<Fac>> getUsers() async{
    final jsondata = await rootBundle.loadString('assets/faculty.json');
    final body = jsonDecode(jsondata) as List<dynamic>;
    return body.map((e)=>Fac.fromJson(e)).toList();
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
          body: Column(
            children: [
              buildSearch(),
              Expanded(
                child: ListView.builder(
                  itemCount: allfac?.length ?? 0,
                  itemBuilder: (context, index) {
                    final book = allfac?[index];

                    return Card(
                      borderOnForeground: true,
                      elevation: 2,
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),//
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(book!.facultyNAME.toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(book.sCHOOL.toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(book.cabinDetail.toString()),
                            ),
                          ],
                        ),
                      )
                    );
                  },
                ),
              ),
            ],
          ),
      ),
    );
  }
  Widget buildSearch() => SearchWidget(
    text:query,
    hintText:'Name of faculty',
    onChanged:searchBook,
  );


  void searchBook(String query) {
      final item = getus.where((Fac) {
      final titleLower = Fac.facultyNAME?.toLowerCase() ?? ' ';
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
      }).toList();

    setState(() {
      this.query = query;
      this.allfac = item;
    });
  }
}

class Fac {
  int? eMPID;
  int? iD;
  String? pFIX;
  String? facultyNAME;
  String? sCHOOL;
  String? cabinDetail;

  Fac(
      {
         this.iD,
         this.eMPID,
         this.pFIX,
         this.facultyNAME,
         this.sCHOOL,
         this.cabinDetail
      }
      );

  Fac.fromJson(Map<String,dynamic>json){
    iD =  json['id'];
    eMPID =  json['EMP. ID'];
    pFIX =  json['PFIX'];
    facultyNAME = json['Faculty NAME'];
    sCHOOL = json['SCHOOL'];
    cabinDetail = json['Cabin Detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.iD;
    data['EMP. ID'] = this.eMPID;
    data['PFIX'] = this.pFIX;
    data['Faculty NAME'] = this.facultyNAME;
    data['SCHOOL'] = this.sCHOOL;
    data['Cabin Detail'] = this.cabinDetail;
    return data;
  }
}

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.white);
    final styleHint = TextStyle(color: Colors.white);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFF3F3F40),
        border: Border.all(color: Colors.white),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
            child: Icon(Icons.close, color: style.color),
            onTap: () {
              controller.clear();
              widget.onChanged('');
              FocusScope.of(context).requestFocus(FocusNode());
            },
          )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}


