// import 'package:cuidador_app_mobile/UI/Pages/Contrato/Models/contrato_controller.dart';
import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/format_money_number.dart';
import 'package:cuidador_app_mobile/UI/Pages/Contrato/Models/contrato_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/Contrato/Modules/form_contratacion.dart';
import 'package:cuidador_app_mobile/UI/Pages/Contrato/Modules/sticky_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ContratoPageMain extends StatelessWidget {
  StickyTopBar stickyTopBar = Get.put(StickyTopBar());
  FormContratacion formContratacion = Get.put(FormContratacion());
  FormatMoneyNumber moneyFormat = FormatMoneyNumber();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FocusScope(
        node: FocusScopeNode(),
        child: GestureDetector(
          onTap: () {
            // FocusScope.of(context).unfocus();
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
      bottomSheet: _bottomAccountStatus(),
    );
  }

  Widget _bottomAccountStatus(){
    PersonaModel usuarioActual = PersonaModel.fromJson(GetStorage().read('perfil'));
    Get.lazyPut(() => ContratoController());
    ContratoController con = Get.find<ContratoController>();
    return SizedBox(
      height: Get.height * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Divider(height: 1, color: Colors.grey, thickness: 0.5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Perfil Actual', style: TextStyle(fontSize: 12)),
              Text('Saldo Actual', style: TextStyle(fontSize: 12)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('${usuarioActual.nombre} ${usuarioActual.apellidoPaterno}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
              Obx(()=> Text(moneyFormat.formatCurrencyInMXN(con.saldo.value.saldoActual ?? 0.0), 
                style: const TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ],
      ),
    );
  }

}