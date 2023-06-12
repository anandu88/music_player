import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Playercontroller extends GetxController{
  final audioQuery = OnAudioQuery();
  final audioplayer=AudioPlayer();
  var playindex=0.obs;
  var isplaying=false.obs;
  var duration ="".obs;
  var postion ="".obs;
  var max=0.0.obs;
  var value =0.0.obs;

  @override
  void onInit() {
   
    super.onInit();
    checkpermission();

  }
  updateposition(){
    audioplayer.durationStream.listen((d) {
      duration.value=d.toString().split(".")[0];
      max.value=d!.inSeconds.toDouble();
     });audioplayer.positionStream.listen((p) {
      postion.value=p.toString().split(".")[0];
       value.value=p.inSeconds.toDouble();
      });
  }
  changeDurationtoseconds(seconds){
    var duration =Duration(seconds:seconds);
    audioplayer.seek(duration);
  }
  playsong(String? uri,index){
    playindex.value=index;
    try {audioplayer.setAudioSource(
      AudioSource.uri(Uri.parse(uri!))
    );
    
    audioplayer.play();
    isplaying(true);
    updateposition();
    
      
    } catch (e) {
      SnackBar(content: Text(e.toString()));
      
    }
  }
  
  
  checkpermission()async {
    var permission= await Permission.storage.request();
    if (permission.isGranted) {
      
      
      
    }else{
      checkpermission();
    }
  }

}