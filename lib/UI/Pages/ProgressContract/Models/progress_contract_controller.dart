import 'package:get/get.dart';

import '../../../../Domain/Model/Contrato/contrato_model.dart';

class ProgressContractController extends GetxController{

  RxInt currectStep = 0.obs;
  Rx<ContratoModel> contrato = ContratoModel().obs;

  @override
  void onInit() async{
    contrato.value = ContratoModel();
    super.onInit();
  }

}