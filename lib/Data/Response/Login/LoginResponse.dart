// import 'package:cuidador_app_mobile/Domain/Utilities/connection_string.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/menu_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:get/get.dart';

class LoginResponse extends GetConnect{

  Future<List<PersonaModel>> login(String email, String password) async {
    List<PersonaModel> listadoPerfiles = <PersonaModel>[];

    try
    {
      final response = await get('https://mocki.io/v1/6e29936f-39bd-4e1a-9a9b-667492557b27');
      for(var item in response.body){
        listadoPerfiles.add(PersonaModel.fromJson(item));
      }
    }
    catch(e)
    {
      Get.snackbar('Ups! Ha Ocurrido un error!', e.toString());
    }
    return listadoPerfiles;
  }

  Future <List<MenuModel>> getMenus() async {
    List<MenuModel> menus = <MenuModel>[];
    try
    {
      final response = await get('https://mocki.io/v1/b2421eff-8bb3-410a-a6f8-f219fcc1a2d6');
      for(var item in response.body){
        menus.add(MenuModel.fromJson(item));
      }
    }
    catch(e)
    {
      Get.snackbar('Ups! Ha Ocurrido un error!', e.toString());
    }
    return menus;
  }

}