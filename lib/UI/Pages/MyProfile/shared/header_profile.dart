import 'package:cuidador_app_mobile/Domain/Model/Perfiles/persona_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderProfile{

  Widget contenidoHeaderProfile(PersonaModel persona){
    return Container(
      height: Get.height * 0.25,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        // border: Border(
        //   bottom: BorderSide(
        //     color: Colors.grey,
        //     width: 1
        //   )
        // )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _avatarAndName(image: persona.avatarImage!),
          Text(persona.nombre!, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
          Text('${persona.apellidoMaterno} ${persona.apellidoPaterno}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white54),),
          // _contatcInfo(
          //   title1: '477 520 3086', 
          //   title2: '477 671 0279', 
          //   title3: 'Calle 1 #123',
          //   icono1: CupertinoIcons.phone, 
          //   icono2: CupertinoIcons.phone_circle_fill, 
          //   icono3: CupertinoIcons.house_alt_fill
          // )
        ],
      ),
    );
  }

  Widget _avatarAndName({required String image}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ClipOval(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            width: 120.0, // El mismo tamaño que el contenedor
            height: 120.0, // El mismo tamaño que el contenedor
          ),
        ),
      ],
    );
  }

  Widget _contatcInfo({
    required String title1, required String title2, String? title3, 
    required IconData? icono1, required IconData? icono2, IconData? icono3}
    ){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _formatText('Familiar: Cristiano Ronaldo', CupertinoIcons.person_crop_square_fill),
      _formatText('Telefono: 477 520 3086', CupertinoIcons.phone),
        title3?.isEmpty == true ? const SizedBox() :
         _formatText('Domicilio: Brisa del sol 126a, Brisas del pedregal', CupertinoIcons.house_alt_fill)
      ],
    );
  }

  Widget _formatText(String text, IconData icono){
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icono, color: Colors.grey[700],),
          SizedBox(width: Get.width * 0.1,),
          Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[700]),),
        ],
      ),
    );
  }

}