import 'dart:ui';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:location/location.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);
  @override
  State<Maps> createState() => _Maps();
}
Position? position;
class _Maps extends State<Maps> {
  @override
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(12.843094, 80.154419),
    zoom: 16.0,
  );
  late MapmyIndiaMapController controller;
  static const String MAP_SDK_KEY = "c16143b8f02a81e4b579e62f44f84ac2";
  static const String REST_API_KEY = "c16143b8f02a81e4b579e62f44f84ac2";
  static const String ATLAS_CLIENT_ID = "33OkryzDZsLgSX8ZNfcFh_NZnVbvZL90-xQKj9fTH4nyidx_tD37Zxlg3swjbOfqde3PQlZ9CB6TbUinIS4hDw==";
  static const String ATLAS_CLIENT_SECRET = "lrFxI-iSEg-c8clcrjpNYP-pi2KfJM_OxVQzAYZdVy8jsm9umpy22DsfS6sOEV3lXYRzR3i_RMTkn1wkZr9ekajiJMQ02XXZ";
  void setPermission() async {
    if (!kIsWeb) {
      final location = Location();
      final hasPermissions = await location.hasPermission();
      if (hasPermissions != PermissionStatus.granted) {
        await location.requestPermission();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    MapmyIndiaAccountManager.setMapSDKKey(MAP_SDK_KEY);
    MapmyIndiaAccountManager.setRestAPIKey(REST_API_KEY);
    MapmyIndiaAccountManager.setAtlasClientId(ATLAS_CLIENT_ID);
    MapmyIndiaAccountManager.setAtlasClientSecret(ATLAS_CLIENT_SECRET);
    setPermission();
  }

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
        body: MapmyIndiaMap(
          initialCameraPosition: _kInitialPosition,
          onMapCreated: (map) =>
          {
            controller = map,
          },
          onStyleLoadedCallback: () => {
            addMarker()
          },
          zoomGesturesEnabled: true,
          rotateGesturesEnabled: true,
          doubleClickZoomEnabled: true,
          compassEnabled: true,
        ),
    );
  }
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return controller.addImage(name, list);
  }

  void addMarker() async {
    await addImageFromAsset("icon", "assets/images/marker.png");
    controller.addSymbol(SymbolOptions(geometry: LatLng(12.843094, 80.154419), iconImage: "icon",iconSize: 0.5,textField: "Vit chennai"));
    controller.addSymbol(SymbolOptions(geometry: LatLng(position?.latitude ?? 12.843094, position?.longitude ?? 80.154419), iconImage: "icon",iconSize: 0.4,textField: "Vit chennai"));
  }
}

