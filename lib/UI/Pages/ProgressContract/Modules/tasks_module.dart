import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksModule {

  Widget taskList(){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: Get.height * 0.15, left: 10, right: 10),
        height: Get.height * 0.73,
        width: Get.width,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index){
            return _itemList(
              title: 'Nombre Tarea 1',
              time: '18:00 PM',
              description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In et sem aliquet, tristique elit id, rutrum sapien. Nunc fermentum tellus eget'
            );
          },
        ),
      ),
    );
  }

  Widget _itemList({
    String title = 'Nombre Tarea',
    String time = '18:00 PM',
    String description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In et sem aliquet, tristique elit id, rutrum sapien. Nunc fermentum tellus eget volutpat blandit. ',
    int idTask = 0
  }){
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: Get.width * 0.9,
      height: Get.height * 0.2,
      decoration: ShapeDecoration(
        color: const Color(0xFF484848),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 20,
            offset: Offset(0, 10),
            spreadRadius: 0,
          )
        ],
      ),
      child: SizedBox(
        width: Get.width * 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              
                  SizedBox(
                    height: Get.height * 0.16,
                    width: Get.width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(time,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width * 0.7,
                              child: Text(description ,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
              
                ],
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.small(
                    tooltip: 'Cancelar Tarea',
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: const Color(0xFF891F0D),
                    onPressed: (){},
                    child: const Icon(CupertinoIcons.xmark_circle_fill, color: Colors.white,),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton.small(
                    tooltip: 'Posponer Tarea',
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: const Color.fromARGB(255, 133, 137, 13),
                    onPressed: (){},
                    child: const Icon(CupertinoIcons.pause_circle_fill, color: Colors.white,),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton.small(
                    tooltip: 'Iniciar Viaje',
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: const Color(0xFF0D7289),
                    onPressed: (){},
                    child: const Icon(CupertinoIcons.play_circle_fill, color: Colors.white,),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

}