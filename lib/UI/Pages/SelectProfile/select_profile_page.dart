import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:cuidador_app_mobile/Domain/Utilities/letter_dates.dart';
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
          
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('¿Con cual de las siguientes personas registradas deseas entrar?', 
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(10),
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
    LetterDates letterDates = LetterDates();
    double fontSizeTitle = 15;
    TextStyle styleSub = const TextStyle(fontSize: 13, fontWeight: FontWeight.w500);
    return GestureDetector(
      onTap: () => controller.initAppProfile(persona),
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 20),
        width: Get.width * 0.6,
        height: Get.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(0, 2)
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                    child: Image.network(
                      persona.avatarImage!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('${persona.nombre} ${persona.apellidoPaterno} ${persona.apellidoMaterno}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                ],
              ),
      
              const Divider(),
              const Text('Datos Personales', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),),
      
              // const SizedBox(height: 10),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Edad:', style: TextStyle(fontSize: fontSizeTitle, fontWeight: FontWeight.w500),),
                  Text('${letterDates.calcularEdad(persona.fechaNacimiento!)} años', style: styleSub),
                ],
              ),
      
              // const SizedBox(height: 10),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Genero:', style: TextStyle(fontSize: fontSizeTitle, fontWeight: FontWeight.w500),),
                  Text(persona.genero!, style: styleSub,),
                ],
              ),
      
              // const SizedBox(height: 10),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Estado Civil:', style: TextStyle(fontSize: fontSizeTitle, fontWeight: FontWeight.w500),),
                  Text(persona.estadoCivil!, style: styleSub),
                ],
              ),
      
              // const SizedBox(height: 10),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Correo:', style: TextStyle(fontSize: fontSizeTitle, fontWeight: FontWeight.w500),),
                  Text(persona.correoElectronico!, style: styleSub),
                ],
              ),
      
              // const SizedBox(height: 10),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Telefono:', style: TextStyle(fontSize: fontSizeTitle, fontWeight: FontWeight.w500),),
                  Text(persona.telefonoMovil!, style: styleSub),
                ],
              ),
      
              // const SizedBox(height: 10),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Curp:', style: TextStyle(fontSize: fontSizeTitle, fontWeight: FontWeight.w500),),
                  Text(persona.curp!, style: styleSub),
                ],
              ),
      
              persona.domicilio == null ? const SizedBox() : Column(
                children: [
                  const Divider(),
                  const Text('Domicilio', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),),
                  
                  Text('${persona.domicilio!.calle ?? ''}, ${persona.domicilio?.numeroInterior ?? ''}, ${persona.domicilio?.numeroExterior ?? ''}, ${persona.domicilio?.colonia ?? ''}, ${persona.domicilio?.ciudad ?? ''}, ${persona.domicilio?.estado ?? ''}', style: styleSub),
                ],
              ),
      
          ],
        )
      ),
    );
  }

}