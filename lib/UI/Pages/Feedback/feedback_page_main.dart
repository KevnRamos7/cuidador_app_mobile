
import 'package:cuidador_app_mobile/Domain/Model/Feedback/feedback_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
import 'package:cuidador_app_mobile/UI/Pages/Feedback/Models/feedback_controller.dart';
import 'package:cuidador_app_mobile/UI/Shared/Containers/screens_states.dart';
import 'package:cuidador_app_mobile/UI/Shared/TextFields/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FeedbackPageMain extends StatelessWidget {
  const FeedbackPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    FeedbackController controller = Get.put(FeedbackController());
    ScreenStates screenStates = Get.put(ScreenStates());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tus solicitudes'),
      ),
      body: Obx(() {
        return controller.isLoadingList.isTrue ? screenStates.loadingScreen() : Column(
          children: [
            Expanded(child: Image.asset('assets/img/introductions/intro_2.png')),
            Expanded(child: _buildListRequest(controller)),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(onPressed: () {_buildModalBottomSheet(controller);}, child: const Icon(Icons.add, color: Colors.white,))),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildListRequest(FeedbackController controller) {
    LetterDates letterDates = LetterDates();
    return ListView.builder(
      itemCount: controller.feedbackList.length,
      itemBuilder: (context, index) {
        FeedbackModel feedback = controller.feedbackList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: feedback.estatus! == 21 ? Colors.green : (feedback.estatus! == 20 ? Colors.orange : Colors.red),
          elevation: 4,
          child: ExpansionTile(
            trailing: const Icon(Icons.arrow_drop_down,color: Colors.white,),
            title: Text(
              'Solicitud ${index + 1} - ${letterDates.formatearSoloFecha(feedback.fecha!) ?? ''}',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            children: <Widget>[
              ListTile(
                title: Text(
                  feedback.categoria ?? '',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    feedback.cuerpo ?? '',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _buildModalBottomSheet(FeedbackController controller) {
    TextEditingController _cuerpoController = TextEditingController();
    String categoria = '';
    FormTextfield formTextfield = FormTextfield();
    return Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Nueva solicitud', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField(
                items: controller.categorias.map((String categoria) {
                  return DropdownMenuItem(
                    value: categoria,
                    child: Text(categoria, style: const TextStyle(color: Colors.black),),
                  );
                }).toList(),
                onChanged: (String? value) {
                  categoria = value!;
                },
                decoration: const InputDecoration(
                  hintText: 'Categoria',
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: formTextfield.form_txt(
                controller: _cuerpoController,
                hintText: 'Ingresa el detalle de tu solicitud, ej "No puedo ingresar a la aplicación" o "Añadir nueva funcionalidad"',
                maxLines: 5,
                height: Get.height * 0.2,
                width: Get.width,
                padding: 0
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  controller.addFeedback(FeedbackModel(
                    categoria: categoria,
                    cuerpo: _cuerpoController.text,
                    fecha: '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
                  ));
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: controller.isLoading.value == false
                 ? const Text('Enviar', style: TextStyle(color: Colors.white))
                 :  const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
              ),
            ),
          ],
        ),
      )
    );
  }

}