import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicContainer{

  Widget dynamicContainer({
    required String nombre,
    required double costo,
    required String imagen,
    Function()? onTap,
  }){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: Get.width * 0.75,
      height: Get.width * 0.15,
      decoration: ShapeDecoration(
        color: const Color(0xFF0D7289),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap ?? (){},
            child: const Icon(CupertinoIcons.back, color: Colors.white, size: 20)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nombre, 
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)
                , textAlign: TextAlign.start,
              ),
              Text('Costo por hora: \$ ${costo.toString()}', 
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 12)
              ),
            ],
          ),
          Container(
            width: Get.width * 0.09,
            height: Get.width * 0.09,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: Image.network(imagen, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }

}