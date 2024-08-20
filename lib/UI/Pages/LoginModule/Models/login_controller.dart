import 'package:cuidador_app_mobile/Data/Response/Login/LoginResponse.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/local_auth.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:flutter/material.dart';
// import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{
  
  RxBool temp = false.obs;
  LoginResponse loginResponse = LoginResponse();
  TextEditingController usuarioController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SnackbarUI snackbar = SnackbarUI();
  RxBool isLoad = false.obs;

  Future<void> login() async {

    if(isLoad.value){
      return;
    }

    if(usuarioController.text.trim().isEmpty || passwordController.text.trim().isEmpty){
      snackbar.snackbarError('Campos vacios', 'Por favor llena los campos');
      return;
    }
    isLoad.value = true;

    UsuarioModel response = await loginResponse.login(usuarioController.text.trim(), passwordController.text.trim());
    if (response.idUsuario != null){
      dynamic credenciales = GetStorage().read('credenciales');

      if(credenciales != null){
        if(credenciales['usuario'] != usuarioController.text.trim()){
          GetStorage().remove('credenciales');
          Get.defaultDialog(
            title: 'Guardar Inicio de Sesión',
            middleText: '¿Deseas iniciar la proxima vez con tus datos biometricos?',
            onConfirm: () {
              LocalAuth.authenticate().then((value) {
                if(value){
                  Map<String, dynamic> credenciales = {
                    'usuario': usuarioController.text.trim(),
                    'password': passwordController.text.trim()
                  };
                  if(GetStorage().read('credenciales') == null){
                    GetStorage().write('credenciales', credenciales);
                  }
                  Get.offNamedUntil('select_profile', (route) => false, arguments: response);
                }
                else{
                  Get.offNamedUntil('select_profile', (route) => false, arguments: response);
                }
              });
            },
            onCancel: () => Get.back()
          );
        }
        else{
          Get.offNamedUntil('select_profile', (route) => false, arguments: response);
        }
      }
      else{
        Get.defaultDialog(
          title: 'Guardar Inicio de Sesión',
          middleText: '¿Deseas iniciar la proxima vez con tus datos biometricos?',
          onConfirm: () {
            LocalAuth.authenticate().then((value) {
              if(value){
                Map<String, dynamic> credenciales = {
                  'usuario': usuarioController.text.trim(),
                  'password': passwordController.text.trim()
                };
                if(GetStorage().read('credenciales') == null){
                  GetStorage().write('credenciales', credenciales);
                }
                Get.offNamedUntil('select_profile', (route) => false, arguments: response);
              }
              else{
                Get.offNamedUntil('select_profile', (route) => false, arguments: response);
              }
            });
          },
          onCancel: () => Get.back()
        );
      }
    }
    isLoad.value = false;
  }

  void loginBiometrico() async{
    dynamic credenciales = GetStorage().read('credenciales');
    if(credenciales != null){
      isLoad.value = true;
      UsuarioModel response = await loginResponse.login(credenciales['usuario'], credenciales['password']);
      if (response.idUsuario != null){
        Get.offNamedUntil('select_profile', (route) => false, arguments: response);
      }
      isLoad.value = false;
    }
  }


}