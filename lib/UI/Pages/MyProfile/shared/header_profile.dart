import 'dart:io';

import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Models/my_profile_cliente_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HeaderProfile{

  Widget contenidoHeaderProfile(PersonaModel persona){
    return Container(
      height: Get.height * 0.3,
      width: double.infinity,
      padding: EdgeInsets.only(top: Get.height * 0.07),
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _avatarAndName(image: persona.avatarImage!),
          Text(persona.nombre!, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
          Text('${persona.apellidoMaterno} ${persona.apellidoPaterno}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white54),),
        ],
      ),
    );
  }

  Widget _avatarAndName({required String image}){
    MyProfileClienteController con = Get.find();

    final ImagePicker picker = ImagePicker();

    Future<void> pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        con.pickedImage.value = File(pickedFile.path);
        con.uploadImage();
      }
    } 

    Future<void> save() async {
      switch(con.currentIndex.value){
        case 1:
          await con.updateProfile();
          break;
        case 2:
          await con.updateDomicilio();
          break;
        case 3:
          await con.updateDatosMedicos();
          break;
        case 4:
          await con.updatePadecimientos();
          break;
      }
    }

    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => pickImage(),
              child: Stack(
                children: [
                  ClipOval(
                    child: Image.network(image, width: Get.width * 0.3, height: Get.width * 0.3, fit: BoxFit.cover,),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[800],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white,),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Obx(()=>
          con.currentIndex.value > 0 ? Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              tooltip: 'Actualizar', 
              icon: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.white70, size: 30,), 
              onPressed: () {
                save();
              }
            ),
          ) : const SizedBox(),
        ),
      ],
    );
  }


}