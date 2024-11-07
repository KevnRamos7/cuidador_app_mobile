import 'package:cuidador_app_mobile/UI/Pages/CuidadorReview/Models/review_controller.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/star_container.dart';
import 'package:cuidador_app_mobile/UI/Shared/TextFields/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewContainer{

  FormTextfield formTextfield = Get.put(FormTextfield());

  TextEditingController comentario = TextEditingController();

  Widget reviewContainer({
    required Widget content,
  }){
    Get.lazyPut(() => ReviewController());
    ReviewController controller = Get.find<ReviewController>();

    if(controller.comentarioEdit.value.calificacion != null){
      comentario.text = controller.comentarioEdit.value.comentario!;
      controller.rating.value = controller.comentarioEdit.value.calificacion!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      height: Get.height * 0.5,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          
          const Text('¿Como calificarías tu experiencia servicio?', style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Anek Malayalam',
            fontWeight: FontWeight.w500,
            height: 0,
          ), textAlign: TextAlign.center,),

            Obx(() {
            ReviewController controller = Get.find<ReviewController>();
            return SizedBox(
              width: Get.width * 0.7,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return GestureDetector(
                onTap: () {
                  controller.rating.value = index + 1;
                },
                child: RoundedStar(
                  color: index < controller.rating.value ? Colors.yellow : Colors.grey,
                  size: 30,
                ),
                );
              }),
              ),
            );
            }),

          const Text('¿Te gustaría dejar algun comentario adicional sobre tu experiencia en este cuidado?', style: TextStyle(
            color: Colors.black,
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
          ), textAlign: TextAlign.center,),

          formTextfield.form_txt(
            hintText: 'Ej. Fue un cuidado bastante agradable, muy atento el cuidador',
            maxLines: 40,
            controller: comentario,
            height: Get.height * 0.15,
            padding: 20,
            width: Get.width * 0.9,
            contentPaddingLeft: 20,
            contentPaddingTop: 10
          ),

          controller.comentarioEdit.value.idComentarios != null ? _buttonEdit() : _buttonSave(),

        ],
      ),
    );
  }

  Widget _buttonEdit(){
    Get.lazyPut(() => ReviewController());
    ReviewController controller = Get.find<ReviewController>();
    return SizedBox(
      width: Get.width * 0.8,
      height: Get.height * 0.05,
      child: Obx(()=>
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 7, 74, 89),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: () {
            controller.loadingSend.value == true ? null : controller.actualizarComentario(comentario.text);
          },
          child: controller.loadingSend.value == true ? const CupertinoActivityIndicator(color: Colors.white) :
           const Text('Editar Mi Reseña', style: TextStyle(
            color: Colors.white,
              fontSize: 16,
              fontFamily: 'Anek Malayalam',
              fontWeight: FontWeight.w500,
              height: 0,
          )),
        ),
      ),
    );
  }

  Widget _buttonSave(){
    Get.lazyPut(() => ReviewController());
    ReviewController controller = Get.find<ReviewController>();
    return SizedBox(
      width: Get.width * 0.8,
      height: Get.height * 0.05,
      child: Obx(()=>
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 7, 74, 89),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: () {
            controller.loadingSend.value == true ? null : controller.enviarReview(5, comentario.text);
          },
          child: controller.loadingSend.value == true ? const CupertinoActivityIndicator(color: Colors.white) :
           const Text('Guardar Mi Reseña', style: TextStyle(
            color: Colors.white,
              fontSize: 16,
              fontFamily: 'Anek Malayalam',
              fontWeight: FontWeight.w500,
              height: 0,
          )),
        ),
      ),
    );
  }

}