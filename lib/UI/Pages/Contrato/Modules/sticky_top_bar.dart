
import 'package:cuidador_app_mobile/UI/Shared/Containers/dynamic_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StickyTopBar{

  DynamicContainer dynamicContainer = Get.put(DynamicContainer());

  Widget topInteractiveNav(
    {
      required Function() onTap,
      required String nombre,
      required double costo,
      required String imagen,
      required RxBool enable,
      String? rutaVolver
    }
  ){
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: Get.height * 0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            dynamicContainer.dynamicContainer(
              onTap: () => Get.offNamedUntil(rutaVolver ?? '/home', (route) => false),
              nombre: nombre, 
              costo: costo, 
              imagen: imagen
            ),

            Container(
              width: Get.width * 0.1,
              height: Get.width * 0.1,
              decoration: ShapeDecoration(
                color: const Color(0xFFFAFAFA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 15,
                    offset: Offset(0, 10),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: GestureDetector(
                onTap: () => enable.value == true ? onTap() : null,
                child: Obx(()=> Icon(CupertinoIcons.paperplane_fill, color: enable.value == true ? Colors.blue : Colors.grey, size: 20)))
            )

          ],
        ),
      ),
    );
  }

}