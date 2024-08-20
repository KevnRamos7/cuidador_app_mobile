import 'package:cuidador_app_mobile/Data/Response/Profile/profile_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Domain/Model/Perfiles/usuario_model.dart';

class ProfileCuidadorController extends GetxController{

  ProfileResponse profileResponse = ProfileResponse();
  Rx<UsuarioModel> profileCuidador = UsuarioModel().obs;
  Rx<Color> colorBg = Colors.white.obs;
  RxBool isLoading = false.obs;

  Map<String, Color> colorNames = {
    "Bronce": const Color.fromARGB(255, 118, 61, 11),
    "Plata": const Color.fromARGB(255, 89, 93, 96),
    "Gold": const Color.fromARGB(255, 161, 122, 6),
    "Diamante": const Color.fromARGB(255, 8, 61, 87),
  };

  @override
  void onInit() async{
    super.onInit();
    isLoading.value = true;
    try{
      int id = Get.arguments;
      profileCuidador.value = await profileResponse.getProfileCuidador(id);
      profileCuidador.refresh();
      colorBg.value = colorNames[profileCuidador.value.nivelUsuario] ?? Colors.grey;
    }catch(e){
      isLoading.value = false;
    }
    isLoading.value = false;
  }

}