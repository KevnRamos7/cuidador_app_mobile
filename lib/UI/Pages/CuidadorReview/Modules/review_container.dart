import 'package:cuidador_app_mobile/UI/Shared/Containers/star_container.dart';
import 'package:cuidador_app_mobile/UI/Shared/TextFields/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewContainer{

  FormTextfield formTextfield = Get.put(FormTextfield());

  Widget reviewContainer({
    required Widget content,
  }){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      height: Get.height * 0.5,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          
          const Text('¿Como calificarías tu experiencia servicio?', style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Anek Malayalam',
            fontWeight: FontWeight.w500,
            height: 0,
          ), textAlign: TextAlign.center,),

          SizedBox(
            width: Get.width * 0.7,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedStar(
                  color: Colors.yellow,
                  size: 30,
                ),
                RoundedStar(
                  color: Colors.yellow,
                  size: 30,
                ),
                RoundedStar(
                  color: Colors.yellow,
                  size: 30,
                ),
                RoundedStar(
                  color: Colors.yellow,
                  size: 30,
                ),
                RoundedStar(
                  color: Colors.yellow,
                  size: 30,
                ),
              ],
            ),
          ),

          const Text('¿Te gustaría dejar algun comentario adicional sobre tu experiencia en este cuidado?', style: TextStyle(
            color: Colors.black,
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
          ), textAlign: TextAlign.center,),

          formTextfield.form_txt(
            hintText: 'Ej. Fue un cuidado bastante agradable, muy atento el cuidador',
            maxLines: 40,
            controller: TextEditingController(),
            height: Get.height * 0.15,
            padding: 20,
            width: Get.width * 0.9,
            contentPaddingLeft: 20,
            contentPaddingTop: 10
          ),

          _buttonSave(),

        ],
      ),
    );
  }

  Widget _stars(bool isActive){
    return Container(
      width: 39,
      height: 35,
      decoration: ShapeDecoration(
        color: isActive ? const Color(0xFFF6F600) : Colors.grey,
        shape:  const StarBorder(
          points: 5,
          innerRadiusRatio: 0.38,
          valleyRounding: 0,
          rotation: 0,
          squash: 0,
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 10,
            offset: Offset(0, 5),
            spreadRadius: 0,
          )
        ],
      ),
    );
  }

  Widget _buttonSave(){
    return SizedBox(
      width: Get.width * 0.8,
      height: Get.height * 0.05,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 7, 74, 89),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        onPressed: () {},
        child: const Text('Guardar Mi Reseña', style: TextStyle(
          color: Colors.white,
            fontSize: 16,
            fontFamily: 'Anek Malayalam',
            fontWeight: FontWeight.w500,
            height: 0,
        )),
      ),
    );
  }

}