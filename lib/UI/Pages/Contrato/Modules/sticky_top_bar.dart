
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
      required String imagen
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
              onTap: () => Get.back(),
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
                onTap: () => onTap(),
                child: const Icon(CupertinoIcons.paperplane_fill, color: Colors.blueGrey, size: 20))
            )

          ],
        ),
      ),
    );
  }

}