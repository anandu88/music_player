import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List< SongModel> data;
  const Player({super.key, required this.data, });


  @override
  Widget build(BuildContext context) {
    var controller=Get.find<Playercontroller>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () =>  Column(
            children: [
              Expanded(child: 
              Container(height: 280,
              width: 280,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,color: Colors.redAccent
                ),
                child: QueryArtworkWidget(id: data[controller.playindex.value].id
                , type:ArtworkType.AUDIO,
                artworkHeight: double.infinity,
                artworkWidth: double.infinity,
                nullArtworkWidget:const Icon(Icons.music_note
                ),)
              )),
              const SizedBox(height: 10,),
            Expanded(child: Container(alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.amber,
                
              ),
              child: Column(
                children:  [
                   Text(data[controller.playindex.value].displayNameWOExt,style: const TextStyle(
                    fontSize: 24,fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(height: 10,),
                    Text(data[controller.playindex.value].artist.toString(),style: const TextStyle(
                    fontSize: 20,fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () =>  Row(
                      children: [ 
                         Text(controller.postion.value,
                        style:const TextStyle(),),
                        Expanded(child: Slider(value:controller.value.value, 
                        max:controller.max.value ,
                        min: const Duration(seconds: 0).inSeconds.toDouble(),
                        
                        onChanged: (newvalue){
        
                          controller.changeDurationtoseconds(newvalue.toInt());
                          newvalue=newvalue;
                        },)),
                        Text(controller.duration.value,style: const TextStyle(),)
                      ],
                    ),
                  ),
                 const  SizedBox(height: 15,),
                   Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(onPressed: (){
                        controller.playsong(data[controller.playindex.value].uri, controller.playindex.value - 1);
                      },
                       icon: const Icon(Icons.skip_previous_rounded,size: 40,)),
                        Obx(
                         () =>   IconButton(onPressed: (){
                            if(controller.isplaying.value){
                              controller.audioplayer.pause();
                              controller.isplaying(false);
                            }else{
                              controller.audioplayer.play();
                              controller.isplaying(true);
                            }
                          },
                                           icon: controller.isplaying.value? const Icon(Icons.pause,size: 50,):
                                           const Icon(Icons.play_arrow,size: 50,)
                                           ),
                        ),
                        IconButton(onPressed: (){
                          controller.playsong(data[controller.playindex.value].uri, controller.playindex.value + 1);
                        },
                       icon: const Icon(Icons.skip_next,size: 40,))
                    ],
                   ),
                 
                ],
              ),
            ))
              
            ],
          ),
        ),
      ),
    );
  }
}