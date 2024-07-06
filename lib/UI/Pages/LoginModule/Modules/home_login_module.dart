import 'package:cuidador_app_mobile/UI/Pages/LoginModule/Modules/bottom_model_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeLoginModule {

  BottomModelLogin modelLogin = Get.put(BottomModelLogin());

Widget loginHomeModule() {
  return SizedBox(
    height: Get.height * 0.9,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        topGradient(),
        centerContainer(),
        bottomGradient()
      ],
    ),
  );
}

Widget centerContainer(){
  return SizedBox(
    height: Get.height * 0.6,
    width: Get.width * 0.9,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        SizedBox(
          height: Get.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/img/introductions/logotipo.png', width: 180, height: 180,),
              
              Text('Gracias por ser parte de nuestra comunidad, juntos hacemos del cuidado una experiencia excepcional'
                , style: GoogleFonts.anekMalayalam(color: Colors.black45, fontSize: 15)
                , textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        SizedBox(
          height: Get.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

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
                    onPressed: (){}, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(CupertinoIcons.smiley, color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                        Text('Ingresar con Face ID', 
                        style: GoogleFonts.anekMalayalam(
                          fontSize: 15, 
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ),
                ),

              const SizedBox(height: 10),

              SizedBox(
                  width: Get.width * 0.7,
                  child: GestureDetector(
                    onTap: () => modelLogin.modalLoginBottom(),
                    child: const Text('Ingresa con contraseña'
                      , style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w600)
                      , textAlign: TextAlign.center,
                    ),
                  )
              ),

              // Container(
              //   margin: EdgeInsets.only(top: Get.height * 0.025),
              //   height: Get.height * 0.05,
              //   width: Get.width * 0.8,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('¿No tienes cuenta? ', style: GoogleFonts.anekMalayalam(color: Colors.black45, fontSize: 15)),
              //       GestureDetector(
              //         child: Text('Regístrate', style: GoogleFonts.anekMalayalam(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w600)),
              //       )
              //     ],
              //   ),
              // ),

            ],
          ),
        ),
      ],
    ),
  );
}

Widget topGradient(){
  return SizedBox(
      width: double.infinity, // Ajusta el ancho según sea necesario
      height: 150, // Ajusta la altura según sea necesario
      child: Image.asset('assets/img/login/topGradient.png', fit: BoxFit.fill)
    );
} 

Widget bottomGradient(){
  return SizedBox(
    height: Get.height * 0.2,
    width: double.infinity,
    child: Image.asset('assets/img/login/bottomGradient.png', fit: BoxFit.fill)
  );
} 

}