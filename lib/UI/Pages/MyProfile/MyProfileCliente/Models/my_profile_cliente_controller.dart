import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyProfileClienteController extends GetxController{

  RxInt currentIndex = 0.obs;
  RxBool inicioRapido = false.obs;

  @override
  void onInit() {
    super.onInit();
    try{
      GetStorage().read('credenciales') != null ? inicioRapido.value = true : inicioRapido.value = false;
    }
    catch(e){
      inicioRapido.value = false;
    }
  }

  void changeIndex(int index){
    currentIndex.value = index;
  }

  void changeInicioRapido(bool value){
    inicioRapido.value = value;
    // if(value == true){
    //   GetStorage().write('credenciales', );
    // }
    // else{
    //   GetStorage().remove('credenciales');
    // }
  }

}