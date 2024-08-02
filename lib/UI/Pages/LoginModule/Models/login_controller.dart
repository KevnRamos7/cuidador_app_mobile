import 'package:cuidador_app_mobile/Data/Response/Login/LoginResponse.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/local_auth.dart';
// import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{
  
  RxBool temp = false.obs;
  LoginResponse loginResponse = LoginResponse();

  Future<void> login(String email, String password) async {
    final response = await loginResponse.login(email, password);
    if(response.isEmpty) {
      Get.snackbar('Inicio de sesión no valido', 'Tu usuario o contraseña son incorrectos');
    }
    else {
      dynamic credenciales = GetStorage().read('credenciales');

      if(credenciales == null){
          Get.defaultDialog(
          title: 'Guardar Inicio de Sesión',
          middleText: '¿Deseas iniciar la proxima vez con tus datos biometricos?',
          onConfirm: () {
            LocalAuth.authenticate().then((value) {
              if(value){
                GetStorage().write('credenciales', response);
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
  }


}