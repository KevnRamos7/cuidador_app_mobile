import 'package:cuidador_app_mobile/Data/Response/Home/HomeResponse.dart';
// import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';



class FeedController extends GetxController{

  SnackbarUI snackbarUI = SnackbarUI();
  HomeResponse  homeResponse = HomeResponse();

  RxList<UsuarioModel> cuidadoresList = <UsuarioModel>[].obs;
  String testRuta = "assets/img/testing/profile_image_test.png";

  @override
  void onInit() {
    super.onInit();
    // PersonaModel().getColorBh();
    setPerfilesCuidadores();
  }

  Future<void> setPerfilesCuidadores() async{
    cuidadoresList.assignAll(await homeResponse.getFeedPage()); 
    for(var i in cuidadoresList){
      PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(i.persona!.first.avatarImage.toString())); 
      i.persona!.first.colorBg = paletteGenerator.dominantColor!.color;
    }
    cuidadoresList.refresh();
  }

  void generatedContrato(UsuarioModel cuidador){
    Get.offNamed('/contratar', arguments: cuidador);
  }


}