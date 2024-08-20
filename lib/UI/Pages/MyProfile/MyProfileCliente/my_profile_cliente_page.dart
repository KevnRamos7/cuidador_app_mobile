import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Models/my_profile_cliente_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Modules/d_medicos_cliente.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Modules/d_personales_cliente.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Modules/domicilio_cliente.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Modules/padecimientos_cliente.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/shared/header_profile.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/shared/list_menu_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../Shared/BottomNavigation/bottom_navigation_main.dart';

class MyProfileClientePage extends StatelessWidget {
  HeaderProfile headerProfile = Get.put(HeaderProfile());
  ListMenuProfile listMenuProfile = Get.put(ListMenuProfile());

  DPersonalesCliente dPersonalesCliente = Get.put(DPersonalesCliente());
  DomicilioCliente domicilioCliente = Get.put(DomicilioCliente());
  DMedicosCliente dMedicosCliente = Get.put(DMedicosCliente());
  PadecimientosCliente padecimientosCliente = Get.put(PadecimientosCliente());

  MyProfileClienteController con = Get.put(MyProfileClienteController());

  @override
  Widget build(BuildContext context) {

    List<Widget> widgets = [
      listMenuProfile.listaMenus(),
      dPersonalesCliente.contenido(),
      domicilioCliente.contenido(),
      dMedicosCliente.contenido(),
      padecimientosCliente.contenido(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        actions: [Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(()=>
          con.currentIndex.value > 0 ? IconButton(tooltip: 'GUARDAR', icon: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.white70, size: 30,), onPressed: () => con.changeIndex(0)) :
           IconButton(tooltip: 'SALIR', icon: const Icon(CupertinoIcons.square_arrow_left_fill, color: Colors.white70, size: 30,), 
           onPressed: () => Get.offNamedUntil('/login', (route) => false),)),
        )],
      ),
      body: FocusScope(
        node: FocusScopeNode(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              headerProfile.contenidoHeaderProfile(PersonaModel(avatarImage: 'assets/img/testing/profile_image_test.png', nombre: 'Kevin Eduardo', apellidoMaterno: 'Ramirez', apellidoPaterno: 'Ramos')),
              Obx(()=> widgets[con.currentIndex.value]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationMain.instance.bottomNavigation(),
    );
  }

  Future<void> _showLogout() async{
    return showBarModalBottomSheet(
      context: Get.context!, 
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        height: Get.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('¿Como deseas cerrar sesión?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () => Get.offNamedUntil('/login', (route) => false), child: const Text('Borrar la sesión actual')),
                ElevatedButton(onPressed: () => Get.back(), child: const Text('Cerrar Sesión')),
              ],
            ),
          ],
        ),
      ),
    );
  }


}