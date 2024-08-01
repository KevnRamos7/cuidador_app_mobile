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
  RxList<UsuarioModel> cuidadoresListSearch = <UsuarioModel>[].obs;
  String testRuta = "assets/img/testing/profile_image_test.png";


  @override
  void onInit() async{
    super.onInit();
    // PersonaModel().getColorBh();
    await setPerfilesCuidadores();
    buscarCuidador('');
  }

  Future<void> setPerfilesCuidadores() async{
    cuidadoresList.assignAll(await homeResponse.getFeedPage()); 
    for(var i in cuidadoresList){
      PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(i.persona!.first.avatarImage.toString())); 
      i.persona!.first.colorBg = paletteGenerator.dominantColor!.color;
    }
    cuidadoresList.refresh();
  }

  void buscarCuidador(String query){

    List<UsuarioModel> dummySearchList = cuidadoresList;

    if (query.isNotEmpty) {
      List<UsuarioModel> searchList = [];
      for (var usuario in dummySearchList) {

        for(var persona in usuario.persona!){

          if (persona.nombre!.toLowerCase().contains(query.toLowerCase()) 
          || persona.apellidoMaterno!.toLowerCase().contains(query.toLowerCase())
          || persona.apellidoPaterno!.toLowerCase().contains(query.toLowerCase())) {
            searchList.add(usuario);
          }

        }

      }
      cuidadoresListSearch.assignAll(searchList);
    } else {
      cuidadoresListSearch.assignAll(cuidadoresList);
    }
  }

  void generatedContrato(UsuarioModel cuidador){
    Get.offNamed('/contratar', arguments: cuidador);
  }


}