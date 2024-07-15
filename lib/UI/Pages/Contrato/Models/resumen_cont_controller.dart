import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/UI/Shared/Snackbar/snackbar_ui.dart';
import 'package:get/get.dart';

class ResumenContController extends GetxController{

  Rx<ContratoModel> contrato = ContratoModel().obs;
  SnackbarUI snackbarUI = SnackbarUI();

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

  

}