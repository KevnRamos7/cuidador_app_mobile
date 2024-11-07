


import 'package:cuidador_app_mobile/UI/Pages/LoginModule/Models/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomModelLogin{

  LoginController loginController = Get.put(LoginController());

  Future<void> modalLoginBottom() async {
    RxBool isVisible = false.obs;
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
            const Text('Ingresa tus Datos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

            // Obx(()=>
              GetStorage().read('credenciales') != null ? _existsUser(GetStorage().read('credenciales')["usuario"]) :
              _textFieldsFormat('Usuario', Icons.person, false, loginController.usuarioController, (){}),
            // ),

            Obx(()=> _textFieldsFormat('Contraseña', isVisible.value == false ? Icons.visibility : Icons.visibility, !isVisible.value, loginController.passwordController, (){
              isVisible.value = !isVisible.value;}
            )),

            SizedBox(
              width: Get.width * 0.7,
              child: Obx(()=>
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: loginController.isLoad.value == true ? Colors.grey : const Color(0xFF395886),
                    // elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                  onPressed: () => loginController.login(),
                  child: loginController.isLoad.value == true ? const SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 0.9,)) :
                    Text('Ingresar', 
                    style: GoogleFonts.anekMalayalam(
                      fontSize: 15, 
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _existsUser(String usuario){
    return Column(
      children: [
        Text(
          'Bienvenido de nuevo : $usuario',
          style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 81, 81, 81)),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => loginController.changeUser(),
          child: const Text(
            '¿Deseas ingresar con otro usuario?',
            style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 68, 129, 226), decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  Widget _textFieldsFormat(String titulo, IconData icono, bool obscureText, TextEditingController controller, Function()? onTap){
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: titulo,
        hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
        suffixIcon: GestureDetector(
          onTap: onTap!(),
          child: Icon(icono, size: 15, color: Colors.grey,)),
      ),
    );
  }

}