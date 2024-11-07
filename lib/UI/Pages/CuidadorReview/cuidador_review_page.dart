import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_item_model.dart';
import 'package:cuidador_app_mobile/Domain/Model/Contrato/contrato_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/CuidadorReview/Models/review_controller.dart';
import 'package:cuidador_app_mobile/UI/Pages/CuidadorReview/Modules/review_container.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/dynamic_container.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/summary_contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CuidadorReview extends StatelessWidget {
  
  ReviewContainer reviewContainer = Get.put(ReviewContainer());
  DynamicContainer dynamicContainer = Get.put(DynamicContainer());
  SummaryContract summaryContract = Get.put(SummaryContract());

  ReviewController controller = Get.put(ReviewController());

  LetterDates letter = LetterDates();

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
        child: Obx(()=>
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          
              dynamicContainer.dynamicContainerBig(
                nombre: controller.contrato.value.personaCuidador!.nombre!,
                ciudad: '${controller.contrato.value.personaCuidador?.domicilio?.ciudad}, ${controller.contrato.value.personaCuidador?.domicilio?.estado}, ${controller.contrato.value.personaCuidador?.domicilio?.pais}',
                importe: controller.contrato.value.importeCuidado ?? 0,
                fecha: letter.formatearSoloFecha(controller.contrato.value.horarioInicio.toString()),
                imagen: controller.contrato.value.personaCuidador?.avatarImage ?? 'assets/img/introductions/isotipo.png'
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
                    ContratoModel(
                      contratoItem: RxList<ContratoItemModel>([
                        ContratoItemModel(
                          horarioInicioPropuesto: controller.contrato.value.horarioInicio,
                          horarioFinPropuesto: controller.contrato.value.horarioFin,
                        )
                      ])
                    )
                  ),
                ],
              ),
          
              reviewContainer.reviewContainer(
                content: Container()
              ),
            ],
          ),
        ),
      ),
    );
  }
}