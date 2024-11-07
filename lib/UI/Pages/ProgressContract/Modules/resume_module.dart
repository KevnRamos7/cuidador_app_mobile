

import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/ProgressContract/Models/progress_contract_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../../../Domain/Utilities/letter_dates.dart';
import '../../../Shared/Containers/summary_contract.dart';

class ResumeModule {

  Widget resume_container(){
    // LetterDates letter = LetterDates();
    SummaryContract summary = SummaryContract();
    Get.lazyPut(() => ProgressContractController());
    ProgressContractController con = Get.find<ProgressContractController>();

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: Get.height * 0.15, left: 10, right: 10),
        height: Get.height * 0.73,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              summary.encabezado('Fechas y Horarios'),
          
              summary.tableForSchedules(con.contrato.value),
      
              summary.encabezado('Observaciones'),
      
              summary.observacionesCard(con.contrato.value),
          
              summary.encabezado('Lista de Tareas'),
          
              summary.tableForTask(con.contrato.value),
            ],
          ),
        )
      ),
    );
  }

}
