import 'package:cuidador_app_mobile/Domain/Model/Perfiles/menu_model.dart';
import 'package:cuidador_app_mobile/UI/Shared/BottomNavigation/btn_nav_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class BottomNavigationController extends GetxController {
//   static final BottomNavigationController _instance = BottomNavigationController._internal();

//   // Factory constructor devuelve la misma instancia cada vez que se llama.
//   factory BottomNavigationController() {
//     return _instance;
//   }

//   // Constructor interno.
//   BottomNavigationController._internal();

//   RxList<MenuModel> parameters = <MenuModel>[].obs;

//   void setMenus(List<MenuModel> newMenus) {
//     parameters.assignAll(newMenus);
//     parameters.refresh();
//     update();
//   }
// }

class BottomNavigationMain {
  // final BottomNavigationController con = Get.find<BottomNavigationController>();

  BtnNavController con = Get.put(BtnNavController());

  static final BottomNavigationMain _instance = BottomNavigationMain._internal();

  static BottomNavigationMain get instance => _instance;

  BottomNavigationMain._internal();

  RxList<MenuModel> parameters = <MenuModel>[].obs;

  // List<Map<String, IconData>> iconoMenu = [
  //   {"FeedPage": CupertinoIcons.house},
  //   {"Dashboard": CupertinoIcons.house},
  //   {"Cuidados": CupertinoIcons.heart},
  //   {"Perfil": CupertinoIcons.person},
  //   {"CuidaHoras": CupertinoIcons.money_dollar_circle_fill}
  // ];

  Widget bottomNavigation() {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
      width: double.infinity,
      height: Get.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          parameters.length,
          (index) => GestureDetector(
            onTap: () { 
              Get.offNamedUntil(parameters[index].rutaMenu ?? '/login', (route) => false);
              con.setIndex(index);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  parameters[index].icono,
                  color: con.index.value == index ? Colors.blue : Colors.grey
                ),
                Text(
                  parameters[index].nombreMenu ?? '',
                  style: TextStyle(
                    color: con.index.value == index ? Colors.blue : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
