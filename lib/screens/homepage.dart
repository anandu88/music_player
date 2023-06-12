import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/screens/player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller =Get.put(Playercontroller());
    return SafeArea(
      child: Scaffold(
        appBar: 
        AppBar(
          title: const Text("my music",style: 
          TextStyle(fontSize: 18,
          color: Colors.orange,
          fontWeight: FontWeight.bold),),
          leading: const Icon(Icons.sort),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.search))
          ],

        ),
        body: FutureBuilder<List<SongModel>>
        (future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType:OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType:UriType.EXTERNAL

        ),
          builder: (context, snapshot) {
            if(snapshot.data==null ){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else if(snapshot.data!.isEmpty) {
              return const Center(child:
               Text("no songs found",style: TextStyle(fontSize: 20,color: Colors.black),));
            }
            else{
              return Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return  Container(margin: const EdgeInsets.only(bottom: 4),
                    child: Obx(
                    () =>  ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        title: Text(snapshot.data![index].displayNameWOExt,
                        style:  const TextStyle(fontSize: 15),),
                        subtitle:  Text("${snapshot.data![index].artist}",
                        style: const TextStyle(fontSize: 15)),
                        leading: QueryArtworkWidget(id: snapshot.data![index].id
                        
                        , type:ArtworkType.AUDIO,
                        nullArtworkWidget: const Icon(
                          Icons.music_note_outlined
                        )),
                        trailing: controller.playindex.value==index&&controller.isplaying.value? const Icon(Icons.play_arrow):null,
                        onTap: () {
                          Get.to(()=> Player(data:snapshot.data!),
                          transition: Transition.downToUp);
                          controller.playsong(snapshot.data![index].uri, index);
                        },
                      ),
                    ),

                    );
                    
                  },),);
            }
          },)
      ),
      
    );
  }
}