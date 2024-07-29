import 'package:cuidador_app_mobile/Data/Request/Contrato/contrato_request.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/status_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResumenContController extends GetxController{

  Rx<ContratoModel> contrato = ContratoModel().obs;
  SnackbarUI snackbarUI = SnackbarUI();
  ContratoRequest contratoRequest = ContratoRequest();
  StatusAlert statusAlert = StatusAlert();

  @override
  void onInit(){
    super.onInit();
    setContrato();
  }

  void setContrato(){
    try
    {
      contrato.value = Get.arguments as ContratoModel;
    }
    catch(e)
    {
      snackbarUI.snackbarError('Ha Ocurrido Un Error', 'Error al cargar el contrato');
    }
  }

  void confirmacionContrato(){
    
    Get.defaultDialog(
      title: '',
      contentPadding: EdgeInsets.symmetric(horizontal: Get.height * 0.02, vertical: 20),
      radius: 8,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.asset('assets/img/introductions/intro_1.png', width: 200, height: 200)),
          const SizedBox(height: 30),
          const Text('Confirmar Contrato', 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.start
          ),
          const SizedBox(height: 20),
          Text('¿Está seguro de confirmar el contrato?, el contrato tendrá un costo final de \$ ${contrato.value.contratoItem!.map((e) => e.importeCuidado).reduce((value, element) => value! + element!).toString()} MXN.', 
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey), textAlign: TextAlign.start
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                minimumSize: Size(Get.width * 0.3, 40),
              ),
              onPressed: (){
                Get.back();
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.black87, fontSize: 16)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                minimumSize: Size(Get.width * 0.3, 40),
              ),
              onPressed: () async{
                bool response = await contratoRequest.saveContratoInDB(contrato.value);
                response ? Get.offNamedUntil('/confirmacion_cont', (route) => false ) : statusAlert.alertError('Ha Ocurrido Un Error', 'Error al guardar el contrato');
              },
              child: const Text('Confirmar', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ]
    );

  }


}