import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:cuidador_app_mobile/UI/Pages/SelectProfile/select_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectProfilePage extends StatelessWidget {
  SelectProfileController controller = Get.put(SelectProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset(
        'assets/img/introductions/isotipo.png', width: 50, height: 50,
        ),
        centerTitle: false,
      ),
      body: contenedor(),
    );
  }

  Widget contenedor(){
    return SizedBox(
      height: Get.height * 0.8,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          
          const Text('¿Con que perfil deseas ingresar?', 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25, 
              fontWeight: FontWeight.bold
            ),
          ),

          Container(
            padding: const EdgeInsets.all(25),
            height: Get.height * 0.6,
            width: Get.width * 0.9,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.listadoPerfiles.length,
              itemBuilder: (context, index){
                return _botonesPerfil(controller.listadoPerfiles[index].nombre!, CupertinoIcons.doc_person, controller.listadoPerfiles[index]);
              }
            ),
          )
        ],
      ),
    );
  }

  Widget _botonesPerfil(String titulo, IconData icono, PersonaModel persona){
    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: Get.width * 0.5,
      height: Get.height * 0.1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.grey, width: 0.5)
          )
        ),
        onPressed: () {
          controller.initAppProfile(persona);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icono, color: Colors.black,),
            Text(titulo, 
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),),
          ],
        ),
      ),
    );
  }

}