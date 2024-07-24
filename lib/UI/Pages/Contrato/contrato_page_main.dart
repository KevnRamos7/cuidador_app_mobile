// import 'package:cuidador_app_mobile/UI/Pages/Contrato/Models/contrato_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/Contrato/Modules/form_contratacion.dart';
import 'package:cuidador_app_mobile/UI/Pages/Contrato/Modules/sticky_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContratoPageMain extends StatelessWidget {
  StickyTopBar stickyTopBar = Get.put(StickyTopBar());
  FormContratacion formContratacion = Get.put(FormContratacion());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FocusScope(
        node: FocusScopeNode(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Obx(()=>
                stickyTopBar.topInteractiveNav(
                  onTap: () => formContratacion.con.saveContrato(),
                  nombre: '${formContratacion.con.personaCuidador.persona!.first.nombre} ${formContratacion.con.personaCuidador.persona!.first.apellidoMaterno}',
                  costo: formContratacion.con.personaCuidador.salarioCuidador ?? 0.0,
                  imagen: formContratacion.con.personaCuidador.persona!.first.avatarImage ?? '',
                  enable: formContratacion.con.contratoItems.isNotEmpty.obs
                ),
              ),
              formContratacion.listForm()
            ],
          ),
        ),
      ), 
    );
  }
}