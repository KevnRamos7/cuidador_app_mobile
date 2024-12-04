import 'package:cuidador_app_mobile/Data/Response/Login/LoginResponse.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/menu_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/usuario_model.dart';
import 'package:cuidador_app_mobile/UI/Shared/BottomNavigation/bottom_navigation_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Domain/Model/Perfiles/persona_model.dart';

class SelectProfileController extends GetxController {

  RxList<PersonaModel> listadoPerfiles = <PersonaModel>[].obs;
  LoginResponse loginResponse = LoginResponse();
  UsuarioModel usuario = UsuarioModel();

  List<MenuModel> menusCliente = <MenuModel>[
    MenuModel(idMenu: 1, nombreMenu: 'FeedPage', rutaMenu: '/home', icono: CupertinoIcons.house),
    MenuModel(idMenu: 2, nombreMenu: 'Cuidados', rutaMenu: '/list_contratos', icono: CupertinoIcons.heart),
    MenuModel(idMenu: 3, nombreMenu: 'Finanzas', rutaMenu: '/finanzas', icono: CupertinoIcons.money_dollar_circle_fill),
    MenuModel(idMenu: 4, nombreMenu: 'Ver Más', rutaMenu: 'my_profile_cliente', icono: CupertinoIcons.equal_circle_fill)
  ];

  List<MenuModel> menusCuidador = <MenuModel>[
    MenuModel(idMenu: 1, nombreMenu: 'Dashboard', rutaMenu: '/dashboard', icono: CupertinoIcons.graph_square_fill),
    MenuModel(idMenu: 2, nombreMenu: 'Cuidados', rutaMenu: '/list_contratos', icono: CupertinoIcons.heart),
    MenuModel(idMenu: 3, nombreMenu: 'Perfil', rutaMenu: 'my_profile_cliente', icono: CupertinoIcons.person),
    MenuModel(idMenu: 4, nombreMenu: 'Finanzas', rutaMenu: '/finanzas', icono: CupertinoIcons.money_dollar_circle_fill)
  ];
  
  @override
  void onInit() async{
    super.onInit();
    await getListadoPerfiles();
  }

  Future<void> getListadoPerfiles() async {
    try
      {
        usuario = Get.arguments;
        listadoPerfiles.assignAll(usuario.persona!);
      }
    catch(e)
      {
        Get.snackbar('Ups! Ha Ocurrido un error!', e.toString());
      }
  }

  void initAppProfile(PersonaModel persona) async{

    BottomNavigationMain.instance.parameters.clear();
    
    if(usuario.tipoUsuarioId == 2){
      BottomNavigationMain.instance.con.setIndex(0);
      BottomNavigationMain.instance.parameters.assignAll(menusCliente);
      Get.toNamed('/home');
    }
    else{
      BottomNavigationMain.instance.con.setIndex(0);
      BottomNavigationMain.instance.parameters.assignAll(menusCuidador);
      Get.offNamedUntil('/dashboard', (route) => false);
    }
    GetStorage().write('perfil', persona.toJson());
    GetStorage().write('usuario', usuario.toJson());
    // Get.offNamedUntil('/home', (route) => false);
  }

}