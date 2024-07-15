import 'package:cuidador_app_mobile/Data/Response/Login/LoginResponse.dart';
// import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  
  RxBool temp = false.obs;
  LoginResponse loginResponse = LoginResponse();

  Future<void> login(String email, String password) async {
    final response = await loginResponse.login(email, password);
    if(response.isEmpty) {
      Get.snackbar('error', '');
    }
    else {
      Get.offNamedUntil('select_profile', (route) => false, arguments: response);
    }
  }

}