import 'package:cuidador_app_mobile/Data/Response/Home/home_response.dart';
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

  RxBool isLoading = false.obs;


  @override
  void onInit() async{
    super.onInit();
    await setPerfilesCuidadores();
    buscarCuidador('');
  }

  Future<void> setPerfilesCuidadores() async{
    isLoading.value = true;
    try{
      cuidadoresList.assignAll(await homeResponse.getFeedPage()); 
      for(var i in cuidadoresList){
        if(i.persona!.first.avatarImage == null){
          PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage(i.persona!.first.avatarImage.toString())); 
          i.persona!.first.colorBg = paletteGenerator.dominantColor!.color;
        }
        else{
          i.persona!.first.colorBg = Colors.grey;
        }
      }
      cuidadoresList.refresh();
      isLoading.value = false;
    }catch(e){
      isLoading.value = false;
      // snackbarUI.snackbarError('Error', 'No se pudo cargar la lista de cuidadores');
    }
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