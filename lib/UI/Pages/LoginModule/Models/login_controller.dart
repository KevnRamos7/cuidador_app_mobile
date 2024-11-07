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

    if( (usuarioController.text.trim().isEmpty || passwordController.text.trim().isEmpty) && GetStorage().read('credenciales') == null){
      snackbar.snackbarError('Campos vacios', 'Por favor llena los campos');
      return;
    }
    isLoad.value = true;

    String usuario = usuarioController.text.trim() == '' ? GetStorage().read('credenciales')['usuario'] : usuarioController.text.trim();
    UsuarioModel response = await loginResponse.login(usuario, passwordController.text.trim());
    if (response.idUsuario != null){
      dynamic credenciales = GetStorage().read('credenciales');

      if(credenciales != null){ // en caso de que sea otro usuario
        if(GetStorage().read('biometric') == false){
          GetStorage().remove('credenciales');
          Get.defaultDialog(
            title: 'Guardar Inicio de Sesión',
            middleText: '¿Deseas iniciar la proxima vez con tus datos biometricos?',
            onConfirm: () {
              LocalAuth.authenticate().then((value) {
                if(value){
                  initSesion(response);
                  GetStorage().write('biometric', true);
                }
                else{
                  snackbar.snackbarError('Autenticación biometrica fallida!', 'Vuelve a intentarlo');
                  Get.back();
                }
              });
            },
            onCancel: () {
              GetStorage().write('biometric', false);
              initSesion(response);
            }
          );
        }
        else{
          initSesion(response);
        }
      }
      else if (GetStorage().read('biometric') == true){ // en caso de que sea el primer usuario
        initSesion(response);
      }
      else{ // en caso de que sea el primer usuario
        Get.defaultDialog(
          title: 'Guardar Inicio de Sesión',
          middleText: '¿Deseas iniciar la proxima vez con tus datos biometricos?',
          onConfirm: () {
            LocalAuth.authenticate().then((value) {
              if(value){
                initSesion(response);
                GetStorage().write('biometric', true);
              }
              else{
                snackbar.snackbarError('Autenticación biometrica fallida!', 'Vuelve a intentarlo');
                Get.back();
              }
            });
          },
          onCancel: () {
            GetStorage().write('biometric', false);
            initSesion(response);
          }
        );
      }
    }
    isLoad.value = false;
  }

  void initSesion(dynamic response) {
    Map<String, dynamic> credenciales = {
      'usuario': usuarioController.text.trim(),
      'password': passwordController.text.trim()
    };
    if(GetStorage().read('credenciales') == null){
      GetStorage().write('credenciales', credenciales);
    }
    Get.offNamedUntil('select_profile', (route) => false, arguments: response);
  }

  void changeUser(){
    GetStorage().remove('credenciales');
    GetStorage().remove('biometric');
    usuarioController.clear();
    passwordController.clear();
    Get.back();
    update();
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