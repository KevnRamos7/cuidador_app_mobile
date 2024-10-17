import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/CuidadorReview/Modules/review_container.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/dynamic_container.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/summary_contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CuidadorReview extends StatelessWidget {
  
  ReviewContainer reviewContainer = Get.put(ReviewContainer());
  DynamicContainer dynamicContainer = Get.put(DynamicContainer());
  SummaryContract summaryContract = Get.put(SummaryContract());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(242, 247, 255, 255),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Reseña de cuidado"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: Get.height * 0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            dynamicContainer.dynamicContainerBig(
              nombre: 'Nombre de Cuidador',
              ciudad: 'Ciudad',
              importe: 2000,
              fecha: '20 de octubre de 2024',
              imagen: 'assets/img/testing/profile_image_test.png'
            ),

            Column(
              children: [
                const Text('Resumen', style: TextStyle(
                  color: Color(0xFF818181),
                  fontSize: 20,
                  fontFamily: 'Anek Malayalam',
                  fontWeight: FontWeight.w600,
                  height: 0,
                )),
                const SizedBox(height: 10),
                summaryContract.tableForSchedules(
                  ContratoModel()
                ),
              ],
            ),

            reviewContainer.reviewContainer(
              content: Container()
            ),
          ],
        ),
      ),
    );
  }
}