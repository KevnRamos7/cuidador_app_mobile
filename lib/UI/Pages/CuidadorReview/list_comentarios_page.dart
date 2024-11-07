import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/CuidadorReview/Models/review_controller.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/screens_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListComentariosPage extends StatelessWidget {
  const ListComentariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ReviewController());
    ReviewController controller = Get.find();
    LetterDates letter = LetterDates();

    ScreenStates screenStates = Get.put(ScreenStates());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Comentarios'), 
      ),
      body: Obx( ()=>
        controller.loadingComentarios.value == true ? screenStates.loadingScreen() : Material(
          child: Column(
            children: [
              _header('${controller.contrato.value.personaCuidador!.nombre!} ${controller.contrato.value.personaCuidador!.apellidoPaterno!} ${controller.contrato.value.personaCuidador!.apellidoMaterno!}', 
                controller.comentarios.length.toDouble()
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.comentarios.length,
                  itemBuilder: (context, index){
                    return _itemForComentarios('${controller.comentarios[index].calificacion} estrellas'
                    , controller.comentarios[index].comentario!
                    , controller.comentarios[index].fechaRegistro == null ? '' : letter.formatearFecha(controller.comentarios[index].fechaRegistro.toString()), controller, index);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton.small(
                  backgroundColor: Colors.blue,
                  onPressed: (){
                    Get.toNamed('/cuidadorReview');
                  }, child: const Icon(CupertinoIcons.add, color: Colors.white,),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(String nombre, double numeroComentarios){
    return Container(
      height: Get.height * 0.2,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(nombre, 
            style: const TextStyle(color: Colors.grey, fontSize: 30, fontWeight: FontWeight.bold,),
          ),

          // const SizedBox(height: 10),

          Text('Has dejado : $numeroComentarios reseñas', 
            style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300, fontFamily: 'Anek Malayalam'),
          ),

        ],
      ),
    );
  }

  Widget _itemForComentarios(String nombre, String comentario, String fecha, ReviewController controller, int index){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      // width: Get.width * 0.75,
      // height: Get.width * 0.15,
      decoration: ShapeDecoration(
        color: const Color.fromARGB(255, 7, 72, 87),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 15,
            offset: Offset(0, 10),
            spreadRadius: 0,
          )
        ],
      ),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
              controller.eliminarComentario(controller.comentarios[index].idComentarios!);
          } else if (direction == DismissDirection.startToEnd) {
              controller.comentarioEdit.value = controller.comentarios[index];
              Get.toNamed('/cuidadorReview');
          }
        },
        background: Container(
          color: Colors.green,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.edit, color: Colors.white),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: ExpansionTile(
          title: Text(nombre, 
        style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.star, color: Colors.yellow,),
          children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(color: Colors.grey, height: 0.5,),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Text(comentario, 
            style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),
          ),
          Text(fecha, 
            style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),
          ),
            ],
          ),
        ),
          ],
        ),
      )
    );
  }

}