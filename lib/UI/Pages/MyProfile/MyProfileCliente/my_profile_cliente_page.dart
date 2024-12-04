import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Models/my_profile_cliente_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Modules/d_medicos_cliente.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Modules/d_personales_cliente.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Modules/domicilio_cliente.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/MyProfileCliente/Modules/padecimientos_cliente.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/shared/header_profile.dart';
import 'package:cuidador_app_mobile/UI/Pages/MyProfile/shared/list_menu_profile.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/screens_states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Shared/BottomNavigation/bottom_navigation_main.dart';

class MyProfileClientePage extends StatelessWidget {

  MyProfileClienteController con = Get.put(MyProfileClienteController());

  HeaderProfile headerProfile = Get.put(HeaderProfile());
  ListMenuProfile listMenuProfile = Get.put(ListMenuProfile());

  DPersonalesCliente dPersonalesCliente = Get.put(DPersonalesCliente());
  DomicilioCliente domicilioCliente = Get.put(DomicilioCliente());
  DMedicosCliente dMedicosCliente = Get.put(DMedicosCliente());
  PadecimientosCliente padecimientosCliente = Get.put(PadecimientosCliente());

  
  ScreenStates states = Get.put(ScreenStates());

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
      body: FocusScope(
        node: FocusScopeNode(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Obx(() =>
           con.loading.value == true ? states.loadingScreen() : Column(
              children: [
                headerProfile.contenidoHeaderProfile(PersonaModel(
                  avatarImage: con.currentUser.value.persona?.first.avatarImage ?? '', 
                  nombre: con.currentUser.value.persona?.first.nombre ?? '', 
                  apellidoMaterno: con.currentUser.value.persona?.first.apellidoMaterno ?? '', 
                  apellidoPaterno: con.currentUser.value.persona?.first.apellidoPaterno ?? '')
                ),
                Obx(() => con.savingModifyData.value == true ? states.loadingScreen() : widgets[con.currentIndex.value]),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationMain.instance.bottomNavigation(),
    );
  }

}