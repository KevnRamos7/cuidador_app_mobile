


import 'package:cuidador_app_mobile/UI/Pages/LoginModule/Models/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomModelLogin{

  LoginController loginController = Get.put(LoginController());

  Future<void> modalLoginBottom() async {
    return await Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        height: Get.height * 0.4,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ingresa tus Datos!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

            _textFieldsFormat('Usuario', Icons.person, false),
            _textFieldsFormat('Contraseña', Icons.lock, true),

            SizedBox(
              width: Get.width * 0.7,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF395886),
                  // elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
                onPressed: () => loginController.login('email', 'password'),
                child: Text('Ingresar', 
                style: GoogleFonts.anekMalayalam(
                  fontSize: 15, 
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
                  textAlign: TextAlign.center,
                )
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _textFieldsFormat(String titulo, IconData icono, bool obscureText){
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: titulo,
        hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
        suffixIcon: Icon(icono, size: 15, color: Colors.grey,),
      ),
    );
  }

}