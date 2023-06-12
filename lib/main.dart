import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:music_player/screens/homepage.dart';


void main(){
  runApp(
    GetMaterialApp(
      title: "beats",
      theme: ThemeData(
        
        
        primarySwatch:Colors.blueGrey,
        appBarTheme: const AppBarTheme(elevation: 1,
        )

        
        
      ),
      debugShowCheckedModeBanner: false,

      home:const Homepage(),
    )
  );
}