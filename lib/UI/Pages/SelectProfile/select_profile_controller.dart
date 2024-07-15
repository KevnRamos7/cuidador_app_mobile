import 'package:cuidador_app_mobile/Data/Response/Login/LoginResponse.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/menu_model.dart';
import 'package:cuidador_app_mobile/UI/Shared/BottomNavigation/bottom_navigation_main.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Domain/Model/Perfiles/persona_model.dart';

class SelectProfileController extends GetxController {

  RxList<PersonaModel> listadoPerfiles = <PersonaModel>[].obs;
  LoginResponse loginResponse = LoginResponse();
  
  @override
  void onInit() {
    super.onInit();
    getListadoPerfiles();
  }

  Future<void> getListadoPerfiles() async {
    try
      {
        listadoPerfiles.assignAll(Get.arguments);
      }
    catch(e)
      {
        Get.snackbar('Ups! Ha Ocurrido un error!', e.toString());
      }
  }

  void initAppProfile(PersonaModel persona) async{

    List<MenuModel> menus = await loginResponse.getMenus();
    BottomNavigationMain.instance.parameters.assignAll(menus);
    GetStorage().write('perfil', persona.toJson());
    Get.offNamedUntil('/home', (route) => false);
  }

}